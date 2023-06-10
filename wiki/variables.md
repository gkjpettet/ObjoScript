A variable is a named thing for storing a value. Variables can store any ObjoScript type including user-defined classes and instances. 

You define a new variable with the `var` keyword:

```objo
var a = 1 + 2
```

This creates a new variable `a` in the current scope containing the value `3`. Once a variable has been defined, it can be accessed by name:

```objo
var hero = "Hulk"
System.print(hero) # Hulk
```
## Scope
ObjoScript has block scope. This means that a variable exists from the point is is defined until the end of the block where that definition appears:

```objo
{
  System.print(a) # Error as `a` doesn't exist yet.
  var a = 123
  System.print(a) # 123
}
System.print(a) # Error as `a` doesn't exist anymore.
```

Variables defined in the top-level of the script are **global** and are visible to the entire script. All other variables are _local_.

Declaring a variable in an inner scope with the same name as an outer one is known as _shadowing_. This is supported:

```objo
var a = "outer"
{
  var a = "inner"
  System.print(a) # inner
}
System.print(a) # outer
```

Declaring a variable with the same name in the _same_ scope **is** an error:

```objo
var a = "hello"
var a = "Garry" # Error as `a` is already declared.
```

## Assignment
After a variable has been declared you can assign to it with `=`:

```objo
var a = 123
a = 234
```

It's an error to assign to a variable before it has been defined:

```objo
a = 123 # Error
```