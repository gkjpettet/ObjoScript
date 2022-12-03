Maps (sometimes known as _dictionaries_ in other languages) associate _keys_ with _values_. They are an efficient data structure so looking up the value of a key is done in near constant time. This means that finding a key is almost independent of the number of keys in the map. This is in contrast to lists.

You can create a map by placing a series of comma-separated entries inside curly braces. Each entry is a key and a value separated by a colon:

```objo
var heroes = {
 "Peter Parker" : "Spider-Man",
 "Tony Stark" : "Iron Man", 
 "Bruce Banner" : "Hulk"
}
```

This creates a map that associates a key (the alter ego) with a value (the superhero's name). String keys and values are shown above but the keys and values can be any type.

It's worth noting that ObjoScript has built-in support for a `KeyValue` class comprised of key-value pairs. The syntax for creating them is:

```objo
var kv = 1 : 2
System.print(kv.key) // 1
System.print(kv.value) // 2
```

## Adding entries
You add new key-values entries to the map using the subscript operator:

```objo
var heroes = {} // Empty map
heroes["Steve Rogers"] = "Captain America"
```

If the key doesn't already exist then it is added. If it does exist, its value is replaced with the new one.

## Looking up values
To find the value associated with a particular key we use the subscript operator again:

```objo
var heroes = {"Tony Stark" : nothing}
System.print(heroes["Tony Stark"]) // nothing (the key exists however)
System.print(heroes["Batman"]) // nothing
System.print(heroes.containsKey("Tony Stark")) // true
System.print(heroes.containsKey("tony stark")) // false as keys are case-sensitive
System.print(heroes.containsKey("Peter Parker")) // false
```

You can get the number of entries in the map with `count()`:

```objo
var heroes = {"Tony Stark" : "Iron Man", "Peter Parker" : "Spider-Man"}
System.print(heroes.count) // 2
```

## Removing entries
To remove an entry from a map call `remove(key)`:

```objo
var heroes = {"Tony Stark" : "Iron Man", "Peter Parker" : "Spider-Man"}
heroes.remove("Tony Stark")
System.print(heroes.containsKey("Tony Stark")) // false
```

If the key was found then `remove(key)` returns the value that was associated with it:

```objo
var heroes = {"Tony Stark" : "Iron Man", "Peter Parker" : "Spider-Man"}
System.print(heroes.remove("Tony Stark")) // Iron Man
```

If the key wasn't found then `nothing` is returned.

To remove all entries from a map use `clear()`.

## Iterating over a map
Whilst you can retrieve a value from a map if you know the key, sometimes you want to iterate over every key-value pair. You can do this with a `foreach` loop:

```objo
var dogs = {
 "small" : "Terrier",
 "medium" : "Beagle", 
 "large" : "Great Dane"
}

foreach dog in dogs {
 System.print("A " + dog.key + " dog: " + dog.value)
}
// A small dog: Terrier
// A medium dog: Beagle
// A large dog: Great Dane
```

The loop variable (in this case `dog`) is a `KeyValue` instance. These instances have two properties: `key` and `value`.

The order that a map iterates over is unspecified but each key-value pair is guaranteed to be iterated over exactly once.

It is possible to iterate over either just a map's key or its values with `Map.keys()` and `Map.values()`:

```objo
var dogs = {
 "small" : "Terrier",
 "medium" : "Beagle", 
 "large" : "Great Dane"
}
foreach size in dogs.keys {
 System.print(size)
}
// small
// medium
// large
```

```objo
var dogs = {
 "small" : "Terrier",
 "medium" : "Beagle", 
 "large" : "Great Dane"
}
foreach breed in dogs.values {
 System.print(bread)
}
// Terrier
// Beagle
// Great Dane
```