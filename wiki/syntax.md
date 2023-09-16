ObjoScript is designed to be easy to pickup and expressive. It is heavily inspired by [Wren]. It's C-like (in that it is a curly braces language) but does not require semicolons after each statement.

Currently ObjoScript compiles scripts directly from source code into bytecode. It does not compile ahead of time. This _may_ change in the future to allow distribution of precompiled ObjoScript code.

## Comments
These begin with `#` and run to the end of the line:

```objo
# This is a comment.
var a = 10 # They can end a line.
var list = [1, 
  2, # They can be within a list or map literal.
  3
]
```

## Reserved words
ObjoScript contains several keywords which cannot be used as identifiers in your code. Like the rest of ObjScript they are **case-sensitive**:

```objo
and, as, asset, breakpoint, class, continue, constructor, else, exit, export, 
false, for, foreach, foreign, function, if, import, in, is, not, nothing, or, 
return, static, super, then, this, true, var, while, xor
```

## Identifiers
Identifiers are used for variable, function and method names. They **must** begin with a lowercase letter and can contain letters, numbers and underscores thereafter. Why do they have to begin with a lowercase letter? Well, it enforces a particular style that I enjoy. They are **case-sensitive**.

```objo
hello
age
camelCase
snake_case
withNumber123
```

## Newlines
Newlines are important in ObjoScript as they signify the end of a statement. They replace the need for semicolons in languages like Java and C.

## Blocks
A block is a lexical scope for the program. Variables declared within a block are scoped to that block. They are used throughout ObjoScript, for example in control statements (like `foreach`) and as the body of functions and methods. A block begins with a `{` and ends with a matching `}`:

```objo
if hungry {
  eat()
} else {
  play()
}

# A block can occur anywhere in your program to provide additional scope:
var a = 10
{
  var a = 20
  System.print(a) # 20
}
System.print(a) # 10
```

[Wren]: https://wren.io