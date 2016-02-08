##Intro

The purpose of this breakout is to connect OOP to where we currently are in our journey as developers.

At first, the concepts of Classes, instances, class methods, instance variables, etc. can seem abstract and confusing. It can feel like an extremely advanced technique that almost doesn't apply to you.

 We want to demonstrate how it provides useful utility to developers of all experience levels.

## Primitive Techniques

 Let's imagine that we are building an online celebrity fan site and need a way to store celebs. Without anymore advanced data types, let's see how this can be done with vanilla variables:

 1. Using Normal Variables

 ```ruby
 celeb_name = 'Britney Spears'
 celeb_age = 33
 ```
 This is simple enough, but things get quite complicated at scale:

 ```ruby
 celeb2_name = 'Johnny Depp'
 celeb2_age = 52
 celeb3_name = 'Sylvester Stallone'
 celeb3_age = 69
 ```
 Clearly, this is unwieldily.

 2. Enter Hashes, Stage left

 ```ruby
 celeb = {}
 celeb[:name] = 'Britney Spears'
 celeb[:age] = 33
 celeb2 = {}
 celeb2[:name] = 'Johnny Depp'
 celeb2[:age] = 52
 ```

 Already, we can see this working much nicer.  Our code is clearly better _organized_, but did you notice it's also more powerful? Simple tasks like updating their birthdate every year are much easier now. We can stick these celebs in an array and loop over them, for example:

 ```ruby
 celebs = [celeb, celeb2]

 for celeb in celebs do
   celeb[:age] += 1
 end
 ```

So this works pretty nice! The only issue is that this is not an elegant way to handle the celeb's ages. Many of our celebs ages are going to be wrong most of the year.

To handle this better, we should be storing their birthdate, and _calculating_ their birthday when we need it, much like (some) humans do:

```ruby
celeb[:birthday] = Time.new(1981, 12, 2)
```

```ruby
((Time.now - celeb[:birthday]) / 60 / 60 / 24 / 365 ).to_i
```
The above code successfully returns an age for any given birthday, let's shove it into a method so we can make full use of it:

```ruby
def get_age(birthday)
  ((Time.now - birthday) / 60 / 60 / 24 / 365 ).to_i
end
```

So this is great! We now have an easy way to calculate anyone's age whenever we need to. The only problem is, now there's one more thing to worry about every time we want to know someone's age.

In real life, we don't want to have to calculate people's ages all the time, so we teach our children to do it themselves! That way, we can just ask people for their ages and _they_ have to figure it out.

This bring us to our first revelation of what makes Classes so valuable.

## Classes

As we've learned, classes allow us to add _behavior_ to our data types. Let's make a class to represent our celebs:

```ruby
class Celeb
end
```

Every instance of a class is going to have a name. I want to be able to say `celeb1.name` and have it return their name. Recalling that this is how we call methods on objects, we can tell that we want a "name" method available on our celebs:

```ruby
class Celeb
  def name
    @name
  end
end
```

```ruby
celeb = Celeb.new
celeb.name
```

 Unfortunately, this code returns nil when we try to check for an celeb's name, because we haven't set it yet. But when we try to set it with `celeb.name =`... we get an error: `NoMethodError: undefined method 'name=' for #<celeb:0x007fbb52113d38>`

Ruby is literally trying to call a method `.name=`, which we haven't defined. Let's try defining it:

```ruby
class Celeb
  def name
    @name
  end
  def name=(arg)
    @name = arg
  end
end
```

Great! We've defined a method to _get_ an celeb's name and a method to _set_ an celeb's name. This code makes an celeb's name fully _accessable_. Now we just need to do the same thing for an celeb's birthday.

```ruby
class Celeb
  def name
    @name
  end
  def name=(arg)
    @name = arg
  end
  def birthday
    @birthday
  end
  def birthday= (arg)
    @birthday = arg
  end
end
```

This class mimics the capabilities of our previous hashes:

```ruby
a = Celeb.new
a.name = "Britney Spears"
a.birthday = Time.new(1981,12,2)
```

Now, let's teach Angelina how to calculate her own age. Let's give her an `.age` method!

```ruby
class Celeb
  def age
    ((Time.now - @birthday) / 60 / 60 / 24 / 365 ).to_i
  end
end
```

And now... drumroll please!

```ruby
a.age
=> 33
```

Violá! We taught celebs how to calculate their own ages. That's one less thing we have to worry about, and that's at the heart of OOP, the magic of teaching your code how to do things

I _abstracted_ that complexity away from me. Never again am I going to have to worry about `((Time.now - @birthday) / 60 / 60 / 24 / 365 ).to_i` or have to remember to call `get_age` on a birthdate.

### Making Things Easier: attr_accessor

Take a look at this code:

```ruby
class Celeb
  def name
    @name
  end
  def name=(arg)
    @name = arg
  end
  def birthday
    @birthday
  end
  def birthday= (arg)
    @birthday = arg
  end
end
```

Doesn't it feel... _wet_? Imagine if we wanted to add more attributes, like gender, country of birth, etc. Adding all these _getters_ and _setters_ to make simple attributes _accessable_ is a pain.

Instead of having to repeatedly create multiple methods for every attribute, Ruby gives us an amazing tool called an attribute _accessor_ that handles making these attributes accessible for us. Take a look:

```ruby
class Celeb
  attr_accessor :name, :birthday
end
```

This works exactly like before. It makes it easy to add other attributes as well:

```ruby
class Celeb
  attr_accessor :name, :birthday, :gender
end
```

## Making Things Easier: Initialize

One more convoluted thing we have to worry about is the process we go through every time we want to create a new celeb:

```ruby
celeb1 = Celeb.new
celeb1.name = 'Britney Spears'
celeb1.bday = Time.new(1975,6,4)
celeb1.gender = 'female'
```

See that `.new` method we're calling? When we call it for `Time`, we pass it everything it needs for right there instead of having to call `Time.new`... `Time.year = 1975`... `Time.month = 6`... But when we call it for celeb we don't have that power.

Again, Ruby gives us a super simple way hook into that new method, and it's called the `initialize` method.

```ruby
class Celeb
  def initialize(name, bday, gender)
    @name = name
    @birthday = bday
    @gender = gender
  end
end
```

Now, we can make new celebs in one line:

```ruby
a = Celeb.new("Britney Spears", Time.new(1975, 6, 4), "female")
```

## In review

We've covered a few ways that OOP makes our lives easier:

1. They provide a superior way of handling data (think `celeb.name` instead of `celeb[:name]`)
2. We can teach them how to do things on their own by giving them methods. They _abstract_ complication away from us by taking care of their own stuff.
3. They come with many convenience tools like `attr_accessor` and `initialize` that make using them as easy or even easier than using some primitive types like Arrays or Hashes.
