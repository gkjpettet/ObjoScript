Most code in ObjoScript resides within class methods but top-level functions are supported.

A function is declared like so:

```objo
# A function with no parameters.
function greet() {
 System.print("Hello!")
}

# A function with a single parameter. Up to 255 parameters
# are supported.
function greetSomeone(who) {
 System.print("Hello " + who + "!")
}

greet() # Hello!
greetSomeone("Garry") # Hello Garry!
```

Functions can be passed around within variables:

```objo
var proxy = greetSomeone
proxy("Aoife") # Hello Aoife!
```

You can get a function's signature like so:

```objo
System.print(greetSomeone) # greetSomeone(_)
```

You cannot declare a function within a class method.

Like methods, function names must begin with a lower case letter. The convention in ObjoScript is for _camelCase_.

## Returning values
You can exit early from a function with the `return` keyword:

```objo
function {
System.print("ok")
return
System.print("never reached")
}
```
A function implicitly returns `nothing` but you can specify a return value like so:

```objo
function add(a, b) { return a + b }
```
