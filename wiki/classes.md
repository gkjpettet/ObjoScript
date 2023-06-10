Every value in ObjoScript is an object and every object is an instance of a _class_. Even `true` and `false` are instances of a class (the `Boolean` class in this case).

Classes define an object's behaviour and state. Behaviour is defined by _methods_ which live on the class. Every object of the same class supports the same methods. State is defined in _fields_, whose values are stored in each instance.

## Defining a class
Classes are created with the `class` keyword:

```objo
class Hero {}
```

This creates a class called `Hero` with no methods or fields. Class names must begin with an uppercase letter. Classes may only be created at the top-level of a script, nested classes are not permitted. This means that classes are always global.

## Methods
To let our hero do something we need to give it methods:

```objo
class Hero {
 attack() {
  System.print("The hero bravely attacks")
 }
}
```

This defines an `attack()` method that takes no arguments. To add parameters, put their names inside the parentheses:

```objo
class Hero {
 attack(who, how) {
  System.print("The hero attacks " + who + " with " + how)
 }
}
```

Since the number of parameters is part of a method's _signature_ a class can define multiple methods with the same name:

```objo
class Hero {
 attack() {
  System.print("The hero bravely attacks")
 }
 
 attack(who) {
  System.print("The hero attacks " + who) }
 
 attack(who, how) {
  System.print("The hero attacks " + who + " with " + how)
 }
}
```

In addition to "regular" methods described above we have two related types of method: _setters_ and _operators_. 

### Setters
A setter has `= after the name, followed by a single parenthesised parameter:

```objo
class Dog {
  owner=(who) {
	System.print("I'm owned by " + who)
  }
}

var terrier = Dog()
terrier.owner = "Garry" # I'm owned by Garry
```

### Operators
The following _prefix_ operators can be implemented by your classes: `-`, `not`, `~`.

Prefix operator methods have an empty parameter list:

```objo
class Hero {
 -() {
  System.print("Does negating a hero make them a villain?")
 }
}

var ironMan = Hero()
-ironMan # Does negating a hero make them a villain?
```

The following _infix_ operators can be implemented by your classes: `&`, `..`, `...`, `==`, `/`, `>`, `>=`, `>>`, `is`, `<`, `<=`, `<<`, `-`, `<>`, `%`, `|`, `+`, `*`.

Infix operator methods have a single parameter for the right-hand operand:

```objo
class Hero {
  +(other) {
  System.print("Adding to a hero is a bit strange.") 
  }
}

var ironMan = Hero()
ironMan + 10 
```

A subscript operator method puts the parameters inside square brackets. At least one and at most 255 parameters are permitted:

```objo
class Hero {
  [index] {
    System.print("index: " + index)
  }

  [x, y] {
    System.print("x: " + x + ", y: " + y)
  }
}

var ironMan = Hero()
ironMan[1] # index: 1
ironMan[5, 10] # x: 5, y: 10
```

A subscript setter looks like a combination of a subscript operator and a setter:

```objo
class Hero {
 [index]=(value) {
  System.print("You can't stuff " + value + " into index " + index)
 }
}

var ironMan = Hero()
ironMan[3] = "something" # You can't stuff something into index 3
```

## Method scope
In the variable section we discussed local and global scope. As ObjoScript is an object-oriented language we also need to consider _object scope_ too. Object scope is the scope that defines the methods that are available on an object. When you write:

```objo
myHero.attack
```

What we mean is "look up the method `attack()` in the scope of the object `myHero`". In this example we are explicitly stating we want to look up the _method_ `attack()` and not a variable named `attack`, that's what the `.` does - the object to the left of the `.` is the object to look up the method on.

### `this`
Things are a little different when your code is within the body of a method. When the method is called on some object and the body is being executed you often need to access that object itself. This is accomplished using `this`:

```objo
class Hero {
 name() { return "Spider-Man" }
 
 printName() {
  System.print(this.name) # Spider-Man
 }
}
```

The `this` keyword is like a special local variable. It always refers to the instance (or class in the case of static methods) whose method is currently being executed. This lets you invoke methods on the object itself.

### Implicit `this`
Using `this.` each time you want to call a method on yourself works but is unnecessary. ObjoScript permits a "self-send" by calling a method without any explicit receiver:

```objo
class Hero {
 name() { return "Spider-Man" }
 
 printName() {
  System.print(name) # Spider-Man
 }
}
```

Implicit `this` gets tricky when there is a global variable with the same name. Consider:

```objo
var name = "variable"

class Hero {
  name { return "Spider-Man" }

  printName() {
	System.print(name) # ???
  }
}
```
Should `printName()` print "variable" or "Spider-Man"? The code within a method's body is not only surrounded by the lexical scope where it's defined but it also has the object scope of the methods on `this`.

ObjoScript uses the following approach to resolve a name inside a method:

1. If there is a local variable inside the method with that name, that is used.
2. If it's method on `this` with the same name, use that.
3. Otherwise we look for a global variable with the same name.

So in the above example ObjoScript prints "Spider-Man".

Here is another illustrative example:

```objo
var shadowed = "surrounding"
var variable = "surrounding"

class Scope {
  shadowed { return "object" }
  variable { return "object" }

  test() {
    var shadowed = "local"
    System.print(shadowed) # "local"
    System.print(variable) # "object"
  }
}
```

## Constructors
We've seen how to define a class and how to declare methods on them. Our Heroes can attack but we need to know how to actually _create them_.

To create a class we simply _call_ it:

```objo
class Hero {}
var myHero = Hero() # Returns an empty instance of Hero
```

Notice how we didn't have to define a constructor when we defined the class. ObjoScript provides a zero-parameter constructor for all classes. Of course you will probably want to do some initialisation in your own classes which is what the `constructor` keyword is for:

```objo
class Hero {
  constructor(name) {
    System.print("I'm " + name)
}

  constructor(name, allegiance) {
    System.print("I'm " + name + " and I'm " + allegiance)
  }
}

var hero1 = Hero("Spider-Man") # I'm Spider-Man
var hero2 = Hero("Hulk", "good") # I'm Hulk and I'm good
```

Notice how we can have multiple constructors, each differing in their _arity_ (number of parameters).

A constructor returns the instance of the class being created, even if you don't explicitly use `return`. It's valid syntax to use `return` inside a constructor but it's an error to have an expression after the return.

## Fields
All state stored in instances is stored in _fields_. Fields start with an underscore (`_`):

```objo
class Rectangle {
  area( return _width * _height )
}
```

Above `_width` and `_height` in the area getter refer to fields on the `Rectangle` instance.

When a field name appears, ObjoScript looks up the field on the instance of that class. You cannot use fields outside of instance methods or constructors.

Unlike variables, fields are implicitly declared simply by assigning to them. If you access a field before it has been initialised then its value is `nothing`.

### Encapsulation
All fields are **private** in ObjoScript. You can only access an object's fields from within methods or constructors defined on that class. More prosaically if you want to make a property of an object visible **you need to define a method to expose it**:

```objo
class Rectangle {
  constructor(width, height) {
    _width = width
	_height = height
  }
  
  width() { return _width }
  height() { return _height }
}

var r = Rectangle(5, 10)
System.print(r.width) # 5
```

To allow outside code to modify a field, **you need to provide setter methods**:

```objo
class Rectangle {
  constructor(width, height) {
	_width = width
	_height = height
  }
  
  # Getters
  width() { return _width }
  height() { return _height }
  
  # Setters
  width=(value) { _width = value }
  height=(value) { _height = value }
}

var r = Rectangle(5, 10)
System.print(r.width) # 5
r.width = 40
System.print(r.width) # 40
```

There are two important points we can deduce from the above:

1. You cannot access fields from a superclass without a getter.
2. You cannot access fields on another instance of your own class.

Whilst this might seem annoying it is a deliberate choice. A true object-oriented language keeps state tightly coupled to each object and ObjoScript adheres to this principle. You don't need to implement setters / getters for most or even any of an object's fields.

## Static Fields
A name that starts with **two** underscores (`__`) is a _static_ field. They are similar to instance fields except that the data is stored on the class itself rather than the instance. They can be used within _both_ instance and static methods and within constructors:

```objo
class Foo {
   static setFromStatic(a) { __a = a }
   setFromInstance(a) { __a = a }

  static printFromStatic() {
    System.print(__a)
  }

  printFromInstance() {
    System.print(__a)
  }
}
```

Just like instance fields, static fields are initially `nothing`:

```objo
Foo.printFromStatic() # nothing
```

They can be used from static methods:

```objo
Foo.setFromStatic("first")
Foo.printFromStatic() # first
```

As well as instance methods. When you do so however there is still only **one** static field shared between all instances of the class:

```objo
var foo1 = Foo()
var foo2 = Foo()

foo1.setFromInstance("second")
foo2.printFromInstance() # second
```

## Static methods
Static methods function very similarly to instance methods except that they operate at the class level. This means they do not have access to instance fields and `this` refers to the class not the instance.

```objo
class Foo {
  static method {
    System.print("This is a static method")
  }

  method {
    System.print("This is an instance method")
  }
}

Foo.method()  # This is a static method
Foo().method() # This is an instance method
```

## Inheritance
A class can inherit from a parent or _superclass_. When you invoke a method on an object or some class and it cannot be found then the runtime checks the chain of superclasses for it.

By default, any new class inherits from `Object` which is the base class that all other classes inherit from. You can specify a different class using `is` when you declare the class:

```objo
class Avenger is Hero {}
```

This declares a new class called `Avenger` that inherits from `Hero`.

You cannot inherit from the built-in core types (e.g. `Boolean`, `Number`, etc). 

The metaclass hierarchy does not parallel the class hierarchy. This means that static methods are not inherited:

```objo
class Hero {
  # Not all heroes can fly.
  static canFly { return false }
}

class Avenger is Hero {}
Avenger.canFly() # Error. Static methods are not inherited.
```

Constructors are also **not** inherited. However you can access them within an instance's constructor(s) with `super`:

```objo
class Hero {
 constructor(name) {
   System.print("My name is " + name)
 }
}

class Avenger is Hero {}

class XMen is Hero {
  constructor(name) {
    super(name)
  }
}

Avenger("Iron Man") # Error as constructors are not inherited.
XMen("Cyclops") # My name is Cyclops
```

## Super
Sometimes you need to invoke a method on yourself but using methods defined in one of your superclasses. You typically do this in an overridden method when you want to access the original method you overwrote. This can be achieved by using the `super` keyword as the receiver in a method call:

```objo
class Base {
  method(arg) {
    System.print("Base got " + arg)
  }
}

class Derived is Base {
  constructor() {
    super.method("value")
  }
}

Base().method("test") # Base got test
Derived() # Base got value
```