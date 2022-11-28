## What is ObjoScript?
ObjoScript is a full-featured standalone and embeddable object-oriented dynamic programming language written entirely in Xojo.

## Why create it?
I needed an embeddable scripting language for an app I'm working on that's written in Xojo. Xojo provides its own scripting engine (XojoScript) and there are several other scripting languages available via plugins (e.g. Wren and Python) however none of them provide any way to debug code written in the scripting language. For my app, it's crucial that the end user is able to step through code written in the scripting language and inspect variables values to help them debug. This is simply impossible in the currently available engines so I decided to implement my own.

## Major features
1. Integrated debugger - step through code line-by-line and inspect local and global variable names and values.
2. Familiar syntax. It's C-like but semicolon free. 
3. Implemented via a stack-based virtual machine. This makes it much faster than tree-walk interpreter languages.
4. Object-oriented. All code executes either within a function or the method of a class. Class fields are private by default and are accessed through method calls.
5. Lovingly crafted. Almost every line of code is commented and there is rich documentation within the source code.
6. Comprehensive test suite. Several hundred tests have been implemented testing every facet of the language and the core library.
7. Cross platform. The desktop dev harness compiles and runs on macOS, Windows and Linux. The ObjoScript VM compiles without issue on iOS.
8. 100% native API 2.0 Xojo code. The only plugins required are for the demo app / bundled code editor. The actual VM is entirely Xojo code.

## More information
For detailed instructions on how to use and for further documentation about the language, see the [Wiki].

## What's in this repo?
1. ObjoScript compiler and virtual machine.
2. Basic IDE including a syntax-highlighting code editor, interactive debugger, bytecode disassembler and AST viewer.
3. Comprehensive automated test suite.

[Wiki]: https://github.com/gkjpettet/ObjoScript/wiki

## Credit
ObjoScript would not be possible without the fantastic previous work of [Bob Nystrom]. ObjoScript is a close approximation to his [Wren] programming language and I have lifted verbatim a lot of his explanations in the documentation. Additional thanks to Bob for his fantastic [Crafting Interpreters book] which I used extensively to get my head around a lot of the fundamentals of language implementation. I can highly recommend purchasing the book even though it is free to read online.

[Bob Nystrom]: http://stuffwithstuff.com
[Wren]: https://wren.io
[Crafting Interpreters book]: http://stuffwithstuff.com
