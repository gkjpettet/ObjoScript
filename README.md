## What is ObjoScript?
ObjoScript is a full-featured standalone and embeddable object-oriented dynamic programming language written entirely in Xojo.

## Why create it?
I needed an embeddable scripting language for an app I'm working on that's written in Xojo. Xojo provides its own scripting engine (XojoScript) and there are several other scripting languages available via plugins (e.g. Wren and Python) however none of them provide any way to debug code written in the scripting language. For my app, it's crucial that the end user is able to step through code written in the scripting language and inspect variables values to help them debug. This is simply impossible in the currently available engines so I decided to implement my own.

## Major features
1. Integrated debugger - step through code line-by-line and inspect local and global variable names and values.
2. Familiar syntax. It's C-like but semicolon free. 
3. Implemented via a stack-based VM. This makes it much faster than tree-walk interpreter languages.
4. Object-oriented. All code executes either within a function or the method of a class. Class fields are private by default and are accessed through method calls.
5. Lovingly crafted. Almost every line of code is commented and there is rich documentation within the source code.
6. Comprehensive test suite. Several hundred tests have been implemented testing every facet of the language and the core library.
7. Cross platform. The desktop dev harness compiles and runs on macOS, Windows and Linux. The ObjoScript VM compiles without issue on iOS.

## How to use
For detailed instructions, see the [Wiki].

[Wiki]: https://github.com/gkjpettet/ObjoScript/wiki
