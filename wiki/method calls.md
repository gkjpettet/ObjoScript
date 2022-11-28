ObjoScript is a true object-oriented language so most code consists of invoking methods on objects:

```objo
System.print("Hello") // Hello
```

You have a _receiver_ (here `System`) followed by a `.` then a method name (`print`) and an optional argument list in parentheses (`"Hello"`). Multiple arguments are separated by commas:

```objo
list.insert(1, "item")
```

The argument list can be empty:

```objo
list.clear()
```

Or even omitted entirely if no parameters are required:

```objo
list.clear
```

The VM executes a method call as follows:

1. Evaluate the receiver and arguments from left to right.
2. Look up the method on the receiver's _class_.
3. Invoke the method, passing in the argument values .

## Signatures
ObjoScript classes can have multiple methods with the same name as long as they have a different _signature_. The signature is the method's name along with the number of arguments it requires. This is known as _overloading by arity_.

As an example, the `String` class has two methods to determine if the string ends with a particular suffix. One method just requires the suffix and assumes a case-sensitive search. The other requires an additional boolean argument specifying if the search should be case-sensitive:

```objo
var s = "Hello World"
s.endsWith("World") // case-sensitive search.
s.endsWith("world", false) // case-insensitive search.
```

In ObjoScript, the above calls are calls to two completely separate methods, `endsWith(_)` and `endsWith(_,_)`. This makes is easier to define overloads since you don't need optional parameters or wasteful control flow to determine which parameters were passed.

This is also much faster to execute. Since the compiler knows how many arguments are passed at compile time we can compile this to directly call the correct method immediately which speeds up the runtime a lot.

## Getters
Some methods exist to expose a stored or computed property to the outside world. We call these _getters_ and you don't need to include empty parentheses after the method name if you don't want to. Convention is to omit them:

```objo
"hello".count // 5
"hello".count() // Also 5
```

## Setters
A setter allows code outside of a class or instance to modify its state:

```objo
rectangle.width = 50
```

Despite the `=`, this is just syntactic sugar for a method call. Specifically the above snippet is a call to the `width=(_)` method on `rectangle` passing in `50` as the argument.

Since the `=(_)` is in the setter's signature, an object can have both a getter and a setter with the same name without a collision:

```objo
class Rectangle {
  width() { return _width } // Getter
  width=(value) { _width = value } // Setter
}
```

## Operators
ObjoScript has most of the operators you're probably familiar with from other programming languages. 

There are three prefix operators: `not`, `~` and `-`. These are method calls on their operand without any other arguments. An expression like `not happy` means "call the `not()` method on `happy`".

There are also lots of infix operators. These have both a left and right-hand operand: `*`, `/`, `%`, `+`, `-`, `..`, `...`, `<<`, `>>`, `<`, `>`, `<=`, `>=`, `==`, `<>`, `&`, `^`, `|` and `is`.

Like prefix operators, infix operators are just method calls. The left-hand operand is the receiver and the right-hand operand is the argument passed to the method. So `a + b` is interpreted by the compiler as `a.+(b)` or "invoke the `+(_)` method on `a` passing in `b` as the argument".

Note that `-` is both a prefix and an infix operator. Since they have different signatures (`-()` and `-(_)`) there is no ambiguity between them.

## Subscripts
Another familiar syntax is subscripting using square brackets (`[]`). This is handy for working with collection-like objects, for example:

```objo
list[0] // Get the first item in a list.
map["key"] // Get the value associated with "key".
```

In ObjoScript, these are also method cals. In the above examples, the signature is `[_]`.

Subscript operators can also take multiple arguments:

```objo
matrix[3, 5]
```

The signature for the above example would be `[_,_]`.

As you might expect, ObjoScript supports _subscript setters_ too:

```objo
list[0] = "item"
map["key"] = "value"
```

The signatures for the above example are both `[_]=(_)`.