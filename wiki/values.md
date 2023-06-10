Values are the basic atomic object types that all other types derive from or are composed of. Like everything in ObjoScript, they too are objects.

## Nothing
`nothing` is the equivalent of `Nil` in Xojo or `null` in other languages. It is an instance of the `Nothing` class. `nothing` represents the absence of a value. If you call a method that doesn't return a value you get `nothing` back.

## Booleans
A boolean value can be either `true` or `false`. They are instances of the `Boolean` class.

## Numbers
ObjoScript has a single numeric type whose class is `Number`. Internally these are stored as Xojo doubles. They look like you might expect:

```objo
0
1234
-5678
3.14159
1.0
-12.34
0.0314159e2
0.0314159e+2
314.159e-2
0xdeadbeef # hexadecimal
0b1001 # binary
```

## Strings
ObjoScript strings are UTF-8 encoded immutable collections of characters that are instances of the `String` class. String literals are created by typing text surrounded by double quotes:

```objo
"hello"
```

To include a `"` inside a string literal you can escape it by preceding it by an additional `"`:

```objo
"Hi ""Superman""" # Hi "Superman"
```

String literals can contain Unicode characters which are represented in two ways:

1. A `\u` followed by four hex digits can be used to specify a Unicode code point:

```objo
"\u0041\u0b83\u00DE" # AஃÞ
```

2. A capital `\U` followed by eight hex digits allows Unicode code points outside of the basic multilingual plane:

```objo
"\U0001F64A\U0001F680" # 🙊🚀
```

