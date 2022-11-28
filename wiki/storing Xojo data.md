An embedded language frequently needs to work with native data. Perhaps you need an ObjoScript object that represents a native resource like a Xojo `FolderItem`, For these cases you can define a **foreign class**. 

Foreign classes are half-in ObjoScript's dynamic world and half-in Xojo's static world. They are real ObjoScript classes with a name, constructors and methods. You can define methods written in ObjoScript and/or foreign methods written in Xojo. You can pass them around, do `is` checks on them, etc but they also wrap a blob of raw memory that is invisible to ObjoScript but accessible to Xojo.

## Defining a foreign class
They are defined like so:

```objo
foreign class Point {
  // ...
}
```

The `foreign` keyword tells ObjoScript to loop in the host Xojo app when it constructs instances of the class. The host is given the opportunity to initialise data in the class.

To talk to the host app the VM needs a delegate to call whenever it instantiates or destroys a foreign class.These delegates are found through a binding process similar to how foreign methods are bound. When you configure the VM you should implement the `BindForeignClass` event. This event requires you to return a pair of delegates wrapped in a `ObjoScript.ForeignClassDelegates` instance. One delegate for instantiation ("allocation") and the other for destruction. The destruction delegate is optional and may be `Nil`.

The allocate delegate looks like this:

```xojo
Sub ForeignAllocateDelegate(vm As ObjoScript.VM, instance As ObjoScript.Instance, arguments() As Variant)
End Sub
```

and the destroy delegate looks like this:

```xojo
Sub ForeignDestroyDelegate(data As Variant)
End Sub
```

ObjoScript invokes the allocate delegate whenever a new instance of a foreign class is created. ObjoScript passes in the new instance and any arguments that were passed to the constructor.

## Foreign data
Every instance in the VM has a `ForeignData` `Variant` property. This is opaque to ObjoScript but you can assign any Xojo value to it. This is the raw data that you will manipulate in your foreign classes. You can see a working example of how is it used in the implementation of the native `List` and `Map` classes. 

## A full example
Let's walk through an example. We'll create a `File` class that wraps the Xojo `FolderItem` class.

In ObjoScript the class we want looks like this:

```objo
foreign class File {
  constructor(path)
  foreign write(text)
}
```

This class will let you create a new file from a path and write to it.

### Setting up the VM
In our host Xojo app we'll setup the VM:

```xojo
Var vm As New ObjoScript.VM
Addhandler vm.BindForeignClass, AddressOf MyClassBindingMethod
AddHandler vm.BindForeignMethod, AddressOf MyMethodBindingMethod
```

### Binding the foreign class
Here's the code to bind a foreign class:

```xojo
Sub MyClassBindingMethod(sender As ObjoScript.VM, className As String) As ObjoScript.ForeignClassDelegates
  If className.CompareCase("File") Then
    Return New ObjoScript.ForeignClassDelegates(AddressOf FileAllocate, Nil) // No destructor
  End If
End Sub
```

Here's the code to call whenever a new File class is constructed:

```xojo
Sub FileAllocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, arguments() As Variant)
  If arguments.Count <> 1 Then
    vm.Error("Expected a single `path` argument.")
  End If
  
  // Get the file as a Xojo FolderItem. Obviously you should do error checking, etc.
  // We'll store it in the instance's foreign data.
  instance.ForeignData = New FolderItem(arguments(0))
End Sub
```

### Binding the foreign method
Here's the code to bind the `write(text)` foreign method:

```xojo
Sub MyMethodBindingMethod(sender As ObjoScript.VM, className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
  If className.CompareCase("File") And methodSignature.CompareCase("write(_)") And Not isStatic Then
    Return AddressOf FileWrite
  End If
End Sub
```

This is the actual Xojo method that will be called whenever `write(_)` is invoked on a `File` instance:

```xojo
Sub FileWrite(vm As ObjoScript.VM)
  // Get the File instance. It will be in slot 0.
  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
  
  // Get the folderitem which is stored in the instance's foreign data.
  Var f As FolderItem = instance.ForeignData
  
  // Get the string to write. It is the first (and only argument) so it's in slot 1.
  Var s As String = vm.GetSlotValue(1)
  
  // Open a text output stream. You should do error checking, etc.
  Var tout As TextOutputStream = TextOutputStream.Open(f)
  tout.Write(s)
  tout.Close
End Sub
```

Now that everything is setup, we can use our `File` class from within ObjoScript:

```objo
var file = File("myFile.txt")
file.write("some text")
```