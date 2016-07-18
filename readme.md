<!-- During the first check for understanding (5 min) (new vs initialize)

White-tabling: give markers out before hand and not midway through a lesson; give cleaning rag halfway through

If it becomes apparent during the CFU that  less than 2/3rds of the class gets the material, go back and review/reframe

Rephrase student answers so that everyone can hear, clarify any fuzziness in answer

Then go back check of Learning Objective!

2nd Check for Understanding (Local, instance or class variables)

Gestures: framing is very important; give clear directions
Call on a quieter student with a correct answer

3rd LO - Determine whether given data and methods are best-suited to being "public" or “private”

ask for students to think of 3 examples of public methods for 1 min, and then to give 1

sample students
if you find yourself running behind you can always CFU during independent practice

Think Pair Share with the last few objectives
For the last 4 learnings objectives
If you were teaching this material, how would you teach this to someone?
Groups of 4 and then present
Hook
Topic Introduction
Example
Demo
Q&A -->



# Intro to Object-Oriented Programming in Ruby

## Learning Objectives

#### By the end of the lesson, students will be able to:

- Explain the relationship between `.new()` and `def initialize()`
- Distinguish whether a piece of data is best-suited to being stored in a local, instance, or class variable
- Determine whether given data and methods are best-suited to being "public" or "private"
- Explain whether given data is best-suited to having its accessibility defined by `attr_accessor`, `attr_reader`, `attr_writer`, or none of the above
- Describe the relationship of `attr_` and "getter" and "setter" methods
- Properly define instance and class variables
- List two ways of defining class methods
- Explain the different use-cases for classes and modules

## Framing: What is OOP? (9:00 - 9:10)

Ruby is an object-oriented language. That means it's based on the idea that you'll build your application with objects in mind.

An object is a collection of related attributes (aka properties) and methods (aka behavior). You can think of an object as a little machine: it has displays you can read and buttons you can push.

When you write an object-oriented application, the idea is that you write the blueprints for these machines, and then you write a sequence of events your users can initiate in which these machines interact with each other.

## The OOP Process

Putting your idea in a nutshell gives you a starting place for what those objects may be:

> "Tic Tac Toe is a game where players try to get three squares in a row."

- Game
- Players
- Squares

> "Facebook is an app where users can post statuses and add friends."

- Users
- Statuses
- Friends

> "Amazon is a site where people can order products."

- People
- Orders
- Products

I'm basically taking the nouns and saying they're objects.

*Players*, *Users*, and *People* are all "human" words. To keep things simple, I'll almost always use **"Users"** to refer to human objects that interact with my app.

#### What might the objects be in...

- A GA homework-grading app?
- A GA attendance-taking app?
- Uber or Lyft?

## Our first object (10:10 - 10:20)

An **object** is an **instance** of a **class**.

A **class** is a blueprint from which objects are made. In javascript we used prototypes and constructor functions, which operate somewhat similarly to **classes** in Ruby. Each object made from a class is an instance of that class. Each instance of a class is an object.

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

- is `User` a(n)...
  - class?
  - instance?
  - object?

- is `alice` a(n)...
  - class?
  - instance?
  - object?

- `User.greet` throws an error. `alice.greet` works fine. So we can deduce that the `greet` method can only be called on...
  - instances of the `User` class
  - the `User` class itself
  - objects

- Thus, would it make sense to call `greet` a(n)...
  - "instance method"?
  - "class method"?
  - "object method"?

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

## Initializing Users (10:20 - 10:30)

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


#### Hypothesis Building (2 min)

In the next 2 minutes, write down 3 sentences venturing an educated guess when we might use each of these two methods, `def initialize` and `new`, describing where each would be written.


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

### Instance variables (10:30 - 10:40)

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

To **get** Juan's first name, I can't simply type `juan.firstname`. To **set** Juan's first name, I can't simply type `juan.firstname = "Jorge"`

The only things available **outside** an instance are its methods. `@firstname` is a property, not a method. We can't access 'data' inside of an instance unless it contains methods that let us do so.

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

## attr_accessor

Recall how we couldn't simply type `juan.firstname="some other name"` in a prior example.

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

## Break  (10:50 - 11:00, 10 min)

___

## You do: Monkies! (11:00 - 11:20, 20 min)

For the next exercise, clone down the repo linked below:
https://github.com/ga-wdi-exercises/oop_monkey


## Class-level stuff

### Class Attributes a.k.a. Class Variables (11:20 - 11:25, 5 min)

I'd like to have a way of getting all users.

```rb
class User
  attr_accessor :firstname, :lastname
  @@all = 0

  def count
    return @@all
  end

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @@all += 1
  end

  def full_name
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
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

But there's somehting weird going on here: note that we aren't counting the number of Steves, Jorges, or Juans. Think about what `.count` might be returning; more on this in a moment!

A variable name beginning with `@@` is a **class variable**. Every instance of a class has the same value for this variable. It cannot be accessed with `attr_accessor`

### Methods (11:25 - 11:30, 5 min)

`.full_name` is an *instance method*: it's called on an instance of User.

There are also methods you call on `User` itself. So far we've only seen `.new`.

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

  def User.new
    puts "I've hijacked a class method and broken core functionality!"
  end

end
```


```rb
juan = User.new("Juan", "Juanson")
# ArgumentError: wrong number of arguments (given 2, expected 0)
juan = User.new
# "I've hijacked a class method and broken core functionality!"
juan.firstname = "Juan"
# => Error!
```

A method name beginning with the class name is a **class method**. It is attached to the class itself, rather than to instances.

### Class attributes/variables and Class methods together (11:30 - 11:40)

`User.count` would make much more sense than `steve.count`.


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

  # Below is one way to define a Class Method!!! You can also use self.count
  def User.count
    return @@all
  end

end
```


```rb
juan = User.new("Juan", "Juanson")
juan.count
# => Error!
User.count
# => 1
```



## Self (11:40 - 11:45, 5 min)

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

  #can also be written as: def User.all
  def self.all
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

## Public and Private (11:45 - 11:50, 5 min)

### You Do

- Draw a picture of a machine, real or imaginary, that has inputs (buttons, switches, keypads...) and displays (dials, lights, screens...). Label what they do.
- Most machines have internal gauges or memories that help it make decisions: temperature monitors, voltage monitors, hard disks, and so on. These are visible only inside the machine: whoever's using the machine can't see them. Draw two of these on your machine and label them.

By default all instance and class methods are *public*, except for `def initialize` which is *private*. This means they're visible to other objects. An analogy: they're functions that have their own buttons on the outside of the machine, like a car's turn signal.

There may be methods that all other objects don't need to know about.

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

## Break (11:50 - 12:00, 10 min)

## You do: Orange Tree (12:00 - 12:20, 20 min)

From Chris Pine's "Learn to Program": p 133, section 13.6

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

Create an OrangeTreeOrchard class that manages multiple OrangeTrees. It can:

- Age all the trees by one year
- pick and count all the fruit
- calculate average height and fruit of all orange trees.

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

## Extra Practice: Scrabble

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
