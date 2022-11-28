Whilst the embedding section explains how to run a compiled ObjoScript function, we still aren't able to do anything particularly interesting because the VM is completely isolated from the outside world. 

To make ObjoScript _useful_ it needs to be able to communicate with your Xojo app. Xojo's scripting language, _XojoScript_ does this through a _Context_ object. ObjoScript however copies Lua and Wren and uses the concept of **slots** and **handles**.

## The slot array
When you want to send data to or read data from ObjoScript with Xojo you do so through an array of _slots_. Think of the slot array as a message board that both the VM and your Xojo app can leave messages on for the other side to process.

The slot array is zero-based and each slot can hold a `Variant`. The VM expects a slot to contain one of the following data types:

- Xojo Boolean
- Xojo Double
- Xojo String
- `ObjoScript.Instance`
- `ObjoScript.Klass`
- `ObjoScript.Func`

### Writing slots
Writing data to a slot is easy:

```xojo
vm.SetSlot(2, "hello") // Sets slot `2` to "hello".
```

### Reading slots
Writing to slots would be pointless if you also couldn't read them so ObjoScript provides methods to do so:

```xojo
Var value As Variant = vm.GetSlotValue(1) // Gets the value from slot 1.
```

If you need a Xojo the VM can return a string representation of the object with this method:

```xojo
Var s As String = vm.GetSlotAsSlot(1)
```

### Looking up variables
You can get access to a **global** variable like so:

```xojo
Var someVariable As Variant = vm.GetVariable("MyClass")
```

`someVariable` may be any of the valid slot types (classes, instances, strings, etc). Since classes are always global in scope, this is a good way to get a reference to a class to manipulate static methods.

### Creating lists
The slot array is fine for moving small numbers of values between ObjoScript and Xojo but sometimes you need to move a large amount of data. The `List` class is great for this so the VM provides an easy way to create `List` instances from Xojo:

```xojo
Var emptyList As ObjoScript.Instance = vm.NewList()

// Assume `items()` is a Variant or String array.
Var list As ObjoScript.Instance = vm.NewList(items)
```

## Handles
Slots are good for moving data between ObjoScript and Xojo but they have two limitations:

1. **They are short-lived**. As soon as you execute more ObjoScript code the slot array is invalidated.
2. **The only support primitive types**. 

To address these limitations, we have _call handles_. A call handle wraps a reference to a method on a particular class or instance. 

To create a call handle we need to put the receiver of the method (a class or instance) into slot 0 and we need the signature of the method to call. 

Let's say we have a static method called `update(delta)` on a class called `GameEngine` that we want to repeatedly call from Xojo. We first need to put the `GameEngine` class into slot 0:

```xojo
If Not vm.GetVariableInSlot("GameEngine", 0) Then
  // The VM can't find the `GameEngine` class.
End If

Var gameEngine As ObjoScript.Klass = vm.GetSlot(0)
```

The we can create a handle for the update method:

```xojo
Var updateHandle As ObjoScript.CallHandle = vmCreateHandle("update(_)")
```

Now `updateHandle` is a permanent reference to the `update(_)` method on the `GameEngine` class. We can invoke it whenever we like. All we have to do is ensure that any arguments (in this case, there is one argument) are in the appropriate slots before invoking. Slot 1 is the first argument, slot 2 the second and so on:

```xojo
// We want to call GameEngine.update(delta) with a value of `16`.

// Put the argument into slot 1.
vm.SetSlot(1, 16)

// Invoke the handle.
vm.InvokeHandle(updateHandle)
```
