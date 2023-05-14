A list is a single-dimensional collection of objects where each element in the list can be referenced with an integer index. These are equivalent to arrays in Xojo. Elements can be of any type, including other lists. Lists are instances of the `List` class.

Here is a list containing three elements of various types:

```objo
[10, "monkey", true]
```

## Accessing elements
Accessing an element in a list is done by calling the `subscript operator` on the list with the (0-based) index of the element you want:

```objo
var heroes = ["Iron Man", "Hulk", "Black Panther"]
System.print(heroes[0]) // Iron Man
System.print(heroes[2]) // Black Panther
```

Negative indices count backwards from the end:

```objo
System.print(heroes[-1]) // Black Panther
System.print(heroes[-2]) // Hulk
```

It's a runtime error to pass an index that is out of bounds. You can find the bounds using `count`:

```objo
System.print(heroes.count) // 3
```

### Ranges
A `range` is a list of sequential numeric values. The `Number` class can create them with the inclusive (`...`) and exclusive (`..<`) operators:

```objo
1...5  // [1, 2, 3, 4, 5]
1..<5 // [1, 2, 3, 4]
```

## Slicing a list
Sometimes you just want to get to a portion or _slice_ of a list. The easiest was to do this is to pass a `range` to the list's subscript operator:

```objo
System.print(heroes[1...2]) // [Hulk, Black Panther]
```

This returns a new list comprised of the elements in the original list whose indices were within the range.

Unlike when passing in a single number to a list's subscript operator, ranges only contain positive integers.

## Adding elements
Lists are _mutable_, that is their contents can be changed. 

Swapping an element is achieved with the subscript setter:

```objo
var heroes = ["Iron Man", "Hulk", "Black Panther"]
heroes[0] = "Spider-Man" // [Spider-Man, Hulk, Black Panther]
```

It's a runtime error to set an element that is out of bounds. To increase the size of a list, use `add(item)` to append a single item to the end of the list:

```objo
var heroes = ["Iron Man", "Hulk", "Black Panther"]
heroes.add("Spider-Man") // [Iron Man, Hulk, Black Panther, Spider-Man]
```

You can insert an element at a specific index using `insert(index, item)`:

```objo
var letters = ["a", "b", "c"]
letters.insert(3, "d")   // Inserts at the end.
System.print(letters)    // [a, b, c, d]
letters.insert(-2, "e")  // Counts back from size after insert.
System.print(letters)    // [a, b, c, e, d]
```

The index may be one past the last index in the list to append an element. If `index < 0` it counts backwards from the end of the list. It bases the computation on the length of the list _after_ the inserted the element, so that `-1` will append the element, not insert it before the last element.
If `index` is not an integer or is out of bounds, a runtime error occurs.

## Adding lists
You can concatenate lists together using the `+` operator:

```objo
var letters = ["a", "b", "c"]
var other = ["d", "e", "f"]
var combined = letters + other
System.print(combined)  // [a, b, c, d, e, f]
```

## Removing elements
The opposite of `insert(index, item)` is `removeAt(index)`. This removes the element at the specified index and returns it.

To remove a specific value, use `remove(item)`. This removes and returns the first matching value or returns `nothing` if the value wasn't found.

In both cases, the list is compacted to ensure there are no empty indices.

```objo
var letters = ["a", "b", "c", "d"]
letters.removeAt(1)
System.print(letters) // [a, c, d]
letters.remove("a")
System.print(letters) // [c, d]
```

To remove everything from the list use the `clear()` method:

```objo
var list = [1, 2 ,3]
list.clear() // []
```

## Iterating over a list
Since the `List` class implements the iterator protocol you can iterate over its contents with a `foreach` loop:

```objo
var list = ["a", "b", "c"]

foreach item in list {
 System.print(item)
}
// a
// b
// c
```