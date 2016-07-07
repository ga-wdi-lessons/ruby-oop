# Intro to Object-Oriented Programming in Ruby

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

> "Facebook is a site where users can post statuses and add friends."

- Users
- Statuses
- Friends

> "Amazon is a site where people can order products."

- People
- Orders
- Products

*Players*, *Users*, and *People* are all "human" words. To keep things simple, I'll almost always use **"Users"** to refer to human objects that interact with my app.

## Our first object

An **object** is an **instance** of a **class**.

A class is a blueprint from which objects are made. Each object made from a class is an instance of that class. Each instance of a class is an object.

Copy and paste this code into your REPL:

```rb
class User

  def set_name_to(some_string)
    @name = some_string
  end

  def get_name
    return @name
  end

  def greet
    puts "Hi! My name is #{@name}!"
  end

end
```

Then, copy and paste these lines **one at a time**:

```rb
alice = User.new
alice.set_name_to("Alice")
puts alice.get_name

bob = User.new
bob.set_name_to("Bob")
puts bob.get_name

puts alice.greet
puts bob.greet
```

<details>
<summary>If we change `def set_name_to(some_string)` to `def christen(name)`, what else will need to change?</summary>
`@name = some_string` must become `@name = name`, and `alice.set_name_to("Alice")` must become `alice.christen("Alice")`.
</details>

<details>
<summary>If we change `@name = some_string` to `@username = some_string`, what else will need to change?</summary>
Every `@name` must become `@username`.
</details>

- `User` is a(n)...
  - class
  - instance
  - object

- `alice` is a(n)...
  - class
  - instance
  - object

- `User.greet` throws an error. `alice.greet` works fine. So we can deduce that the `greet` method can only be called on...
  - instances of the `User` class
  - the `User` class itself
  - objects

- Thus, it would be make sense to call `greet` a(n)...
  - "instance method"
  - "class method"
  - "object method"

- `User.new` works fine. `alice.new` throws an error. So we can deduce that the `new` method can only be called on...
  - instances of the `User` class
  - the `User` class itself
  - objects

- Thus, it would be make sense to call `new` a(n)...
  - "instance method"
  - "class method"
  - "object method"

<details>
<summary>`class User` works fine. `class user` throws an error. What's a rule we can deduce about classes from this?</summary>
Class names must begin with a capital letter.
</details>

<details>
<summary>`class UserName` works fine. `class User Name` throws an error. What's a rule we can deduce about classes from this?</summary>
Class names must not contain spaces.
</details>

## Initializing Users

Copy and paste this code into your REPL:

```rb
class User

  def initialize
    puts "I'm a new User"
  end

  def greet
    puts "Nice to meet you!"
  end

end
```

Then, copy and paste these lines **one at a time**:

```rb
alice = User.new
alice.greet

bob = User.new
bob.greet

User
User.new
User.new
```

<details>
<summary>What can we conclude about the relationship of `def initialize` and `.new`?</summary>
The `initialize` method is run every time `.new` is called.
</details>

<details>
<summary>How is this different from other User methods we've seen?</summary>
`initialize` and `new` aren't the same word. Going by what else we've seen, we'd expect to see `User.initialize` correspond to `def initialize`. (Under the hood, `.new` is a separate class method that calls the `initialize` instance method.)
</details>

### You can pass arguments to `initialize`

`initialize` is a special method in its relationship to `.new`, but otherwise it behaves like any other method. This means you can pass arguments to it:

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
# I'm a new User named Juan Juanson
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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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

## You do: Orange Tree

From Chris Pine's "Learn to Program"

http://locker.wdidc.org/Ruby/Learn%20to%20Program.pdf

Make an OrangeTree class that has:

- a `height` method that returns its height in feet
- a `one_year_passes` method that, when called, ages the tree one year

### Check In

- Each year the tree grows taller by one foot
- After 50 years the tree should "die" (its height goes to 0)

### Check In

- After the first 5 years, the tree bears 20 oranges
- You should be able to `count_the_oranges`, which returns the number of oranges on the tree

### Check In

- You should be able to `pick_an_orange`, which reduces the number of oranges by 1
- Ensure that your tree cannot have negative oranges
- Ensure that after each year your tree has 20 total oranges again

### Check In

- The number of oranges the tree bears each year is equal to 20 plus the age of the tree

#### Bonus!

Create an Orange Grove class that manages multiple OrangeTrees. It can:

- Age all the trees by one year
- pick and count all the fruit
- calculate average height and fruit of all orange trees.

## attr_accessor

Copy and paste this snippet into your REPL:

```rb
class User

  def get_name
    return @name
  end

  def set_name(some_string)
    @name = some_string
  end

end
```

Run these lines one at a time:

```rb
alice = User.new
alice.name = "Alice"
# This throws an error
alice.set_name("Alice")
puts alice.get_name
```

Now, copy and paste this snippet into your REPL:

```rb
class User
  attr_accessor :name
end
```

Now, run these lines one at a time:

```rb
alice = User.new
alice.name = "Alice"
puts alice.name
```

<details>
<summary>These have the same result, so we can deduce that `attr_accessor` is a shortcut that does what?</summary>
It creates getter and setter methods for the `name` instance variable.
</details>

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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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

## You do: Monkies!

https://github.com/ga-wdi-exercises/oop_monkey

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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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

### You Do

- Draw a picture of a machine, real or imaginary, that has inputs (buttons, switches, keypads...) and displays (dials, lights, screens...). Label what they do.
- Most machines have internal gauges or memories that help it make decisions: temperature monitors, voltage monitors, hard disks, and so on. These are visible only inside the machine: whoever's using the machine can't see them. Draw two of these on your machine and label them.

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
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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
