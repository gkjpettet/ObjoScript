# Embedding
ObjoScript has been designed to be embedded within a Xojo application so care has been taken to ensure that's its embedding API is robust and simple to use.

Rather than reinvent the wheel, ObjoScript borrows heavily from Wren and Lua's approach to the problem.

## Including ObjoScript in a Xojo project
Before you can use ObjoScript in a Xojo project you need to include two modules and a file. These are:

1. `ObjoScript` module
2. `StringExtensions` module
3. `objo.core` script file

The easiest way to get these dependencies into a Xojo project is to open up the ObjoScript project from the repo (`src/dev harness/ObjoScript.xojo_project`) and copy the folder `ObjoScript`, Then paste that folder into your own project. Finally, the VM needs access to the `objo.core` script file at runtime as it defines the core classes. The VM expects it to be copied into your app's `Resources` folder. You can do this by creating a "Copy Files" build script in the Xojo IDE. If you take a close look at the `ObjoScript.xojo_project` you'll see how it's done.

### The Objoscript module
All classes (e.b. the lexer, parser, compiler and VM) required for ObjoScript can be found within this module. Additionally there are submodules which define the core library behaviour.

### The `StringExtensions` module
Various parts of the ObjoScript toolchain perform heavy string manipulation. This module contains extensions to Xojo's native String class to help with this. I chose to keep these in a separate module rather than bundle them into the `ObjoScript` module as I use them in other projects.

### The `core.objo` script
This is an ObjoScript script file. It contains definitions for the built-in types and all of the core library methods. The ObjoScript compiler compiles this script before your code and prepends it to your compiled code.

## Compiling ObjoScript code
To compile ObjoScript source code, you an instance of an ObjoScript compiler:

```xojo
Var compiler As New ObjoScript.Compiler
```

The compiler takes ObjoScript source code and returns a compiled function that can be executed by the VM:

```xojo
Var main As ObjoScript.Func = compiler.Compile(sourceCode)
```

Whilst the above snippet would work fine if there were no errors in `sourceCode`, you should guard against user error:

```xojo
Var func As ObjoScript.Func = compiler.Compile(sourceCode)
Try
  func = compiler.Compile(sourceCode)
Catch le As ObjoScript.LexerException
  // Something went wrong tokenising the source code.
	
Catch pe As ObjoScript.ParserException
  // One or more parsing errors occurred.
  // These can be access though `compiler.ParserErrors()`.`

Catch ce As ObjoScript.CompilerException
  // A compilation error occurred.
End Try

// `func` is now a valid function.
```

## Setting up the VM
Executing a compiled function in a VM is simple enough:

```xojo
Var vm As New ObjoScript.VM
Try
  vm.Interpret(func)
Catch e As ObjoScript.VMException
  // A script runtime error occurred.
End Try
```

There are a handful of events that the VM can raise that you will likely want to implement in your Xojo app. The most important of these is `VM.Print()`. This event is raised every time a script calls `System.print()`. You can decide what to so with the string passed in. I tend to associate a delegate method with the event:

```xojo
Var vm As New ObjoScript.VM

// VMPRintDelegate is a Xojo method with the signature:
// VMPrintDelegate(sender As ObjoScript.VM, s As String)
AddHandler vm.Print, AddressOf VMPrintDelegate
```

## Winding down the VM
Xojo is a memory-managed language so there's not much to do when terminating a VM. It is good practice however to remove any handlers you added when creating the VM. Following on from the above print delegate:

```xojo
// Remove the handler on the VM.
RemoveHandler vm.Print, AddressOf VMPrintDelegate
```