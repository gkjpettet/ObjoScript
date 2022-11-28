When we're in the world of ObjoScript, the external Xojo world is "foreign" to us, There are two reasons we might want to interact with this foreign world:

1. We want to execute code written in Xojo.
2. We want to store raw Xojo data.

Since ObjoScript is object-oriented, behaviour lives within methods for point (1) we have **foreign methods**. Similarly data lives in objects so for point (2) we have **foreign classes**. This page is about foreign methods and the next is about foreign classes.

A foreign method looks to ObjoScript like a regular method. It's defined on an ObjoScript class and it has a name and a signature. The only difference is that the _body_ of the method is written in Xojo.

A foreign method is declared in ObjoScript like so:

```objo
class Arithmetic {
  foreign static add(a, b)
}
```

The `foreign` keyword tells ObjoScript that the method `add()` is declared on `Arithmetic` but is implemented in Xojo. Both static and instance methods can be foreign.

## Binding foreign methods
When you call a foreign method, ObjoScript needs to figure out which Xojo method to execute. This process is called _binding_. Binding is performed on-demand by the VM. When a class that declares a foreign method is first defined the VM asks the host Xojo app for the methods to use for all foreign methods defined by that class.

The VM does this by raising its `BindForeignMethod()` event. Its signature is:

```xojo
BindForeignMethod(className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
```

Every time a foreign method is first declared, the VM raises this event. It passes the host application the name of the class containing the method, the method's signature and whether or not the method is static or instance. In the above `add()` example, it would pass this:

```xojo
BindForeignMethod("Arithmetic", "add(_,)", True)
```

When you configure the VM in your Xojo app you give the VM the address of the method you want invoked when the VM needs a foreign method binding. Something like this:

```xojo
Var vm As New ObjoScript.VM
AddHandler vm.BindForeignMethod, AddressOf BindForeignMethodDelegate
```

A simplified version of the method might be:

```xojo
Function BindForeignMethodDelegate(sender As ObjoScript.VM, className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
  If className.CompareCase("Arithmetic") Then
    If methodSignature.CompareCase("add(_,_)") Then
	  If isStatic Then
	    Return AddressOf ArithmeticAdd // A Xojo method for adding.
	  End If
	End If
  End If
End Function
```

The implementation above is simplistic and tedious but it should suffice to explain what's happening. The important part is that it returns an `ObjoScript.ForeignMethodDelegate`. 

ObjoScript does this binding process _once_ when the class is first defined and then keeps the delegate reference. This means that _calls_ to foreign methods are fast.

## Implementing a foreign method
Every foreign method must be an `ObjoScript.ForeignMethodDelegate`:

```xojo
Sub ForeignMethodDelegate(vm As ObjoScript.VM)
End Sub
```

Arguments passed from ObjoScript are not passed as Xojo arguments and the method's return value is not a Xojo return value. Instead we go through the **slot array**.

When a foreign method is called from ObjoScript, the VM sets up the slot array with the receiver and arguments to call. The receiver is put into slot 0 and the arguments follow sequentially.

You use the VM's slot API to read the arguments and do whatever you need to in Xojo. If you want the foreign method to return a value use the VM's `SetReturn(value)` method. Following on the from the `add()` example above:

```xojo
Sub ArithmeticAdd(vm As ObjoScript.VM)
  Var a As Double = vm.GetSlotValue(1)
  Var b As Double = vm.GetSlotValue(2)
  vm.SetReturn(a + b)
End Sub
```

Whilst your foreign method is executing, the VM is completely suspended.