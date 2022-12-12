## Control flow
Control flow determines which code paths are executed and how many times. _Branching_ statements (such as `if` and `?:`) decide whether or not to execute some code and _looping_ statements execute something one or more times.

## Truthiness
Control flow requires a decision to be made whether to do something or not. This decision depends on an expression's value. Expressions can be either true or false.

ObjoScript has three simple rules to determine if an expression is true or false:

- The boolean value `false` is false
- `nothing` is false
- Everything else is true

## If statements
The simplest branching statement is the solitary `if` statement:

```objo
var ready = true

// These two statements are identical.
if ready then System.print("ok")
if ready { System.print("ok") }
```
If, as in this case, `ready` evaluates to true then the statement is executed, otherwise it is skipped.

Instead of a single statement, you can include a block of statements:

```objo
if "five" { // Evaluates to true.
 System.print("six")
 System.print("seven")
}
```

The `if` statement can also include an `else` branch that will be executed if the condition evaluates to false:

```objo
var on = true

if on {
 System.print("On!")
} else {
 System.print("Not on")
}
```

## Logical operators
Unlike most operators in ObjoScript which are really syntactic sugar for a method call, the `and` and `or` operators _short circuit_. This means they only evaluate the right-hand operand if the left-hand operand is true.

An `and` expression evaluates the left-hand argument. If it's false it returns that value. Otherwise it evaluates and returns the right-hand argument:

```objo
System.print(false and 1) // false
System.print(1 and 2) // 2
```

The logical `or` expression is reversed. If the left-hand argument is _true_ it is returned. Otherwise the right-hand argument is evaluated and returned:

```objo
System.print(false or 1) // 1
System.print(1 or 2) // 1
```

## The conditional operator
This is also known as the _ternary operator_ since it takes three arguments. It mimics Python's expression:

```nohighlight
trueValue if condition else falseValue
```

Example:

```objo
System.print("Maths checks out" if 1 <> 2 else "Maths is broken")
```

It returns `trueValue` if `condition` is `true` otherwise it returns `falseValue`.

## Switch statements
A switch statement is an alternative to chained `if`...`else` statements. The statement switches the code path to execute depending on `someValue`_:

```objo
switch someValue {
  case anotherValue {
    // Code...
  }
  
  case aFunctionCall(), "literal", 3 * 2 {
    // Code...
  }
  
  else {
    // Executes if none of the cases match `someValue`
  }
}
```

As you can see from the example above, a `switch` statement comprises one or more _cases_. Each case evaluates one or more case values and/or expressions separated by commas. If any of a case's values match the value switched on then the case's body executes. If you provide an optional `else` block then that will execute if none of the cases match.

## While loops
A `while` loop is the simplest type of looping mechanism in ObjoScript. It continues to execute a block of code whilst its condition is true:

```objo
var n = 1
while n <= 3 {
System.print(n)
 n = n + 1
}
// 1
// 2
// 3
```

The above loop evaluates the expression `n <= 3`. If that's true then the body of the loop executes. After execution the program loops back to the top of the `while` statement and re-evaluates the condition. It keeps going until `n > 3`.

## For loops
ObjoScript supports the venerable `for` loop seen in C, Java and many other languages:

```objo
for (var i = 1; i <= 3; i++) {
 System.print(i)
}
// 1
// 2
// 3
```
Within the `()` following the `for` keyword are three statements. Each is optional and can be omitted (but the separating colons must remain). The first statement is the declaration of a loop counter variable that will be in scope within the body of the loop. The second statement is an optional initialiser which runs once when the loop first starts. The final statement is the condition that, when met, will cause the loop to exit. The loop ending condition is evaluated at the beginning of each loop iteration.

## Foreach loops
More expressive than the `for` loop described above, the `foreach` loop allows you to iterate every item in a `Sequence`:

```objo
foreach item in 1..3 {
 System.print(item)
}
// 1
// 2
// 3
```
A foreach loop has three components:

1. A variable name to bind. In the example above that's `item`. The variable will be scoped to the body of the loop.
2. A _sequence_ expression. This determines what you're looping over. It gets evaluated _once_ before the body of the loop. In the above example it's an inclusive range but it can be any object that implements the _iterator protocol_.
3. A body. This gets executed once for each iteration of the loop.

## Exit statements
If you need to immediately exit a loop use the `exit` keyword:

```objo
foreach i in [1, 2, 3, 4] {
 System.print(i)
 if i == 3 then exit
}
// 1
// 2
// 3
```

## Continue statements
During the execution of a loop body, you might decide that you want to skip the rest of this iteration and move on to the next one. You can use a `continue` statement to do that. Execution will immediately jump to the beginning of the next loop iteration (and check the loop conditions):

```objo
foreach i in [1, 2, 3, 4] {
 if i == 2 then continue
 System.print(i)
}
// 1
// 3
// 4
```

## The iterator protocol
A list is probably the most common object you'll iterate over but you can iterate over any class that implements the _iterator protocol_. 

The `foreach` loop knows how to call two particular methods on the object that results from evaluating the expression after the `in` keyword.

When you write a loop like this:

```objo
foreach i in 1..100 {
 System.print(i)
}
```

Internally ObjoScript compiles it into this:

```objo
var iter* = nothing
var seq* = 1..100
while iter* = seq*.iterate(iter*) {
 var i = seq*.iteratorValue(iter*)
 System.print(i)
}
```

First, ObjoScript evaluates the sequence expression and stores it in a hidden variable (written `seq*` in the example but in reality it doesn’t have a name you can use). It also creates a hidden “iterator” variable (`iter*`) and initialises it to nothing.

Each iteration, it calls `iterate(_)` on the sequence, passing in the current iterator value (in the first iteration, it passes in `nothing`.) The sequence’s job is to take that iterator and advance it to the next element in the sequence. (Or, in the case where the iterator is `nothing`, to advance it to the first element). It then returns either the new iterator, or `false` to indicate that there are no more elements.

If `false` is returned, ObjoScript exits out of the loop and we’re done. If anything else is returned, that means that we have advanced to a new valid element. To get that, ObjoScript then calls `iteratorValue(_)` on the sequence and passes in the iterator value that it just got from calling `iterate(_)`. The sequence uses that to look up and return the appropriate element.

The built-in `List` class implements `iterate(_)` and `iteratorValue(_)`` to walk over their respective sequences. You can implement the same methods in your classes to make your own types iterable.