# Intro to Object-Oriented Programming in Ruby

See also: https://github.com/ga-wdi-lessons/ruby-oop-inheritance

## Learning Objectives

- Explain how `.new()` and `def initialize()` are related
- Explain whether a piece of data is best-suited to being stored in a local, instance, or class variable
- Explain whether given data and methods are best-suited to being "public" or "private"
- Explain whether given data is best-suited to having its accessibility defined by `attr_accessor`, `attr_reader`, `attr_writer`, or none of the above
- Describe the relationship of `attr_` and "getter" and "setter" methods
- Properly define instance and class variables
- List two ways of defining class methods

## Framing: What is OOP? (5 minutes)

Ruby is an object-oriented language. That means it's based on the idea that you'll build your application with objects in mind.

An object is a collection of related attributes (aka properties) and methods (aka behavior). You can think of an object as a little machine: it has displays you can read and buttons you can push.

When you write an object-oriented application, the idea is that you write the blueprints for these machines, and then you write a sequence of events your users can initiate in which these machines interact with each other.

## The OOP Process

Putting your idea in a nutshell gives you a starting place for what those objects may be:

> "Tic Tac Toe is a game where players try to get three squares in a row."

- Game
- Players
- Squares

> "Garnet is a site where students can track their homework and attendance."

- Students
- Homework
- Attendance

> "Amazon is a site where people can order products."

- People
- Orders
- Products

Note that each of these has a "human" object. To simplify things, I'm going to call these Users.

## Defining Users

```rb
class User

  def initialize
    puts "I'm a new User"
  end

end
```

A class name must begin with a capital letter.

### `initialize` is a special method that runs whenever you type `.new`.

This is automatic in all Ruby classes.

```rb
# pry
User
# ...nothing happens
User.new
# "I'm a new User"
```

### You can pass arguments to `initialize`

`initialize` is a special method in that it's called by `.new`, but it behaves like any other method: you can pass arguments to it.

```rb
class User

  def initialize(firstname, lastname)
    puts "I'm a new User named #{firstname} #{lastname}"
  end

end
```
```rb
# pry
juan = User.new("Juan", "Juanson")
# I'm a new User named Juan
# => #<User:0x007f96f312b240>
```

### Instance variables

I'd like to have a method that prints the full name of the user.

In Ruby, normal variables are available only inside the method in which they were created.

If you put an `@` before the variable's name, it's available inside the entire `instance` in which it was created.

This is an instance variable.

```rb
class User

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

end
```
```rb
# pry
juan = User.new("Juan", "Juanson")
# => #<User:0x007faf3903f670 @firstname="Juan", @lastname="Juanson">
juan.full_name
# => "Juan Juanson"
```

### Getting and setting

To get Juan's first name, I can't simply type `juan.firstname`. To **set** Juan's first name, I can't simply type `juan.firstname = "Jorge"`

The only things available **outside** an instance are its methods. `@firstname` is a property, not a method.

To make it "gettable" and "settable", I'll need to create getter and setter methods for it.

```rb
class User

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def get_firstname
    return @firstname
  end

  def set_firstname(firstname)
    @firstname = firstname
  end

end
```
```rb
# pry
juan = User.new("Juan", "Juanson")
# => #<User:0x007faf3903f670 @firstname="Juan", @lastname="Juanson">
puts juan.get_firstname
# "Juan"
juan.set_firstname("Jorge")
puts juan.get_firstname
# "Jorge"
```

## Exercise (20 minutes)

Clone this exercise and follow the instructions in the readme.

**[Monkies!!!](https://github.com/ga-dc/oop_monkey)**

### attr_accessor
Since getters and setters are so common, Ruby has a shortcut to create them:

```rb
class User
  attr_accessor :firstname, :lastname

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

end
```
```rb
# pry
juan = User.new("Juan", "Juanson")
# => #<User @firstname="Juan", @lastname="Juanson">
puts juan.firstname
# "Juan"
juan.firstname = "Jorge"
puts juan.full_name
# "Jorge Juanson"
```

### `attr_accessor` is actually a shortcut for two other shortcuts.

```rb
class User
  attr_reader :firstname
  attr_writer :lastname

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

end
```
```rb
juan = User.new("Juan", "Juanson")
juan.firstname
# => "Juan"
juan.lastname
# => Error!
juan.firstname = "Jorge"
# => Error!
juan.lastname = "Anderson"
juan.full_name
# => "Juan Anderson"
```

`attr_reader` creates a *getter* method only. Trying to do `juan.firstname = "Jorge"` will fail.

`attr_writer` creates a *setter* method only. Trying to do `puts juan.lastname` will fail.

`attr_accessor` creates getters and setters.

## Class-level stuff

### Attributes

I'd like to have a way of getting all users.

```rb
class User
  attr_accessor :firstname, :lastname
  @@all = 0

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @@all += 1
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def count
    return @@all
  end

end
```
```rb
juan = User.new("Juan", "Juanson")
juan.count
# => 1
jorge = User.new("Jorge", "Jorgeson")
juan.count
# => 2
jorge.count
# => 2
steve = User.new("Steve", "Steveson")
juan.count
# => 3
jorge.count
# => 3
steve.count
# => 3
```

A variable name beginning with `@@` is a **class variable**. Every instance of a class has the same value for this variable. It cannot be accessed with `attr_accessor`

### Methods

`.full_name` is an *instance method*: it's called on an instance of User.

There are also methods you call on `User` itself. So far we've only seen `.new`.

```rb
class User
  attr_accessor :firstname, :lastname
  @@all = 0

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @@all += 0
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def count
    return @@all
  end

  def User.new
    puts "I've hijacked a class method!"
  end

end
```
```rb
juan = User.new("Juan", "Juanson")
# "I've hijacked a class method!"
juan.firstname
# => Error!
```

A method name beginning with the class name is a **class method**. It is attached to the class itself, rather than to instances.

### Class attributes and methods together

`User.count` would make much more sense than `steve.count`.


```rb
class User
  attr_accessor :firstname, :lastname
  @@all = 0

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @@all += 0
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def User.count
    return @@all
  end

end
```
```rb
juan = User.new("Juan", "Juanson")
# "I've hijacked a class method!"
juan.count
# => Error!
User.count
# => 1
```

## Self

`self` is a special variable that contains the current instance of an object (like `this` in Javascript). It's how the object refers to it*self*.

```rb
class User
  attr_accessor :firstname, :lastname
  @@all = []

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    puts "Creating #{self.firstname}"
    @@all.push(self)
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def User.all
    return @@all
  end

end
```
```rb
juan = User.new("Juan", "Juanson")
# "Creating Juan"
jorge = User.new("Jorge", "Jorgeson")
# "Creating Jorge"
steve = User.new("Steve", "Steveson")
# "Creating Steve"
User.all
# => [#<User @firstname="Juan">, #<User @firstname="Jorge">, #<User @firstname="Steve">]
```

## Public and Private

By default all instance and class methods are *public*. This means they're visible to other objects. An analogy: they're functions that have their own buttons on the outside of the machine, like a car's turn signal.

There may be methods other objects don't need to know about.

```rb
class User
  attr_accessor :firstname, :lastname
  @@all = []

  def initialize(firstname, lastname, password)
    @firstname = firstname
    @lastname = lastname
    @password = encrypt(password)
    @@all.push(self)
  end

  def full_name
    puts "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

  def User.all
    return @@all
  end

  private
  def encrypt(input)
    return input.reverse
  end

end
```
```rb
juan = User.new("Juan", "Juanson", "wombat")
# #<User @firstname="Juan" @password="tabmow">
juan.encrypt("wombat")
# Error! Private method `encrypt`
```

Putting `private` in front of methods means they can be used inside the object, but are not available outside it. An analogy: they're functions that do not have their own buttons on the outside of the machine, like a car's air filter.

`private` is useful mostly for keeping things organized. Consider jQuery: It's already cluttered enough, with all these methods like `.fadeOut` and `.css`. It has lots of other methods hidden inside it that we don't really need to know about.

## Why OOP? (10 mintues)

#### Easy to Understand

Objects help us build programs that model how we tend to think about the world.
Instead of a bunch of variables and functions (procedural style), we can group
relevant data and functions into objects, and think about them as individual,
self-contained units. This grouping of properties (data) and methods is called
*encapsulation*.

#### Managing Complexity

This is especially important as our programs get more and more complex. We can't
keep all the code (and what it does) in our head at once. Instead, we often want
to think just a portion of the code.

Objects help us organize and think about our programs. If I'm looking at code
for a Squad object, and I see it has associated *people*, and those people can
dance when the squad dances, I don't need to think about or see all the code
related to a person dancing. I can just think at a high level "ok, when a squad
dances, all it's associated people dance". This is a form of *abstraction*... I
don't need to think about the details, just what's happening at a high-level.

#### Ensuring Consistency

One side effect of *encapsulation* (grouping data and methods into objects) is
that these objects can be in control of their data. This usually means ensuring
consistency of their data.

Consider the bank account example... I might define a bank account object
such that you can't directly change it's balance. Instead, you have to use the
`withdrawl` and `deposit` methods. Those methods are the *interface* to the
account, and they can enforce rules for consistency, such as "balance can't be
less than zero".

#### Modularity

If our objects are well-designed, then they interact with each other in
well-defined ways. This allows us to refactor (rewrite) any object, and it
should not impact (cause bugs) in other areas of our programs.

## Homework: Scrabble

Clone this exercise and follow the instructions in the readme.

**[Scrabble Word Scorer](https://github.com/ga-dc/scrabbler)**

## Resources

- [Variables cheat sheet](variables.md)
- Other exercises
  - [Monkeys](https://github.com/ga-wdi-exercises/oop_monkey)
  - [Application Config](https://github.com/ga-wdi-exercises/ruby_application_configuration)
  - [Superheroes](https://github.com/ga-wdi-exercises/superheros)
- Screencasts
  - WDI8, Robin
    - [Part 1](https://www.youtube.com/watch?v=-pAFSheGDr0)
    - [Part 2](https://www.youtube.com/watch?v=ZgZCtns27pE)
    - [Part 3](https://youtu.be/npM249VzB0I)
    - [Part 4](https://youtu.be/su_XYcj_Cpk)

## Sample Questions

- Create a Ruby class for a student, initialized with a name and an age.
  - Write a getter for name and age, and a setter for name only
  - Create a new student and demonstrate using all the methods
- Explain the difference between local and instance variables
