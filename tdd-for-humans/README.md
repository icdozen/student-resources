# Instructor script

### What is TDD?

Let's quickly review the test-driven-development workflow, also known as Red, Green, Refactor:

  1. **Add a test (Red)**

    In test-driven development, each new feature begins with writing a test. To write a test, the developer must clearly understand the features specification and requirements.
  2. **Run all tests to verify that the new one fails**

    This validates that:
    * the test harness is working correctly
    * the new test does not mistakenly pass
    * and that the required feature does not already exist.

    This step tests the test itself, in the negative: it rules out the possibility that the new test always passes, and therefore is worthless. We must also verify that the new test fails for the expected reason.
  3. **Write some code**

    The next step is to write some code that causes the test to pass. The new code written at this stage is not perfect and may, for example, pass the test in an inelegant way. _That is acceptable_ because it will be improved and honed in Step 5.
  4. **Run tests (Green?)**

    If all test cases now pass, the programmer can be confident that the new code meets the test requirements! It does not break or degrade any existing features. If any of the tests don't pass, go back to step 3! The new code must be adjusted until they do.
  5. **Refactor code or tests (Refactor)**

    Remember when we said it was ok to be inelegant? This is why. After every green step, we take an opportunity to refactor our code. It's not productive to try and find _better_ solutions before we've found _any_ solutions. Always focus on making the test pass, even if it's inelegant, and then always allow for a refactor step.

### Getting Started

To help us further understand the benefits of TDD, we're going to design a Human using a test driven development process. Make a new directory for this project:

```ruby
# In Terminal
mkdir human
cd human

# A file for our human:
touch human.rb

# RSpec will look for a spec/ folder:
mkdir spec
# And finally a file for our tests (specifications) to reside in:
touch spec/human_spec.rb

# Open the project in your text editor
atom .
subl .
```


### Let's Code

The first step in any TDD process is Red, or make tests to describe what we want our code to do, but that don't pass yet.

One of the benefits of RSpec as our test suite is that we are able to (and should) make our tests extremely easy for even a non technical person to read and understand.

The first element in any RSpec test file is the `describe` block, which indicates the thing we are describing with these tests.

In our case, we're going to be describing (testing) a new `Person` class:

```ruby
# In spec/human_spec.rb
describe Human do

end
```

RSpec is a testing DSL. Recall this means _Domain Specific Language_.  It's important to remember that it's _just Ruby_.  `describe` is just a method call that takes two arguments, 1) The object it is describing and 2) a block containing each of the _Examples_ or tests that describe it.

After describe, the second block present in many RSpec tests is `context`. Defining a context is completely optional, and context doesn't in itself _do anything_ but it serves as a tool to organize our tests in to categories. Let's make a `context` for how our `Human` should behave before breakfast:

```ruby
# In spec/human_spec.rb
describe Human do
  context 'Before breakfast a Person' do

  end
end
```

Finally, after telling RSpec what object we're testing (`describe`) and giving ourselves some context on under which conditions these tests apply (`context`), we're ready to list out the behavior we want from our object:

```ruby
describe Human do
  context 'Before breakfast a Person' do
    it 'should be hungry'
    it 'should be sleepy'
    it 'should be awake after drinking coffee'
    it 'should not be hungry after drinking coffee'
  end
end
```

Just like `describe` and `context`, `it` is just a method. It defines an "Example" (a test), and takes two arguments 1) A string name for the example, and 2) a block containing the actual code for the example.

For the moment, we've omitted passing blocks to our `it` method calls, meaning that RSpec is going to mark these examples as "Pending".

_We know we want our code to behave this way_, so we write it down, almost like todos. There's no need to write these tests at the moment, and in fact we should not write more than one at a time.

Let's try running our tests!

```ruby
# In Terminal, inside human directory
rspec
```

RSpec automatically looks for a `spec` folder, and runs the tests inside of it.

We notice our first error:

`human/spec/human_spec.rb:2:in '<top (required)>': uninitialized constant Human::Person (NameError)`

Ruby saw us pass `Human` as an argument to `describe`, and complained that there's no such thing as a `Human`. Let's fix that:

```ruby
# In human.rb
class Human

end
```

Interesting, same error. What's happening here is that RSpec only loads the test files themselves, it's still up to us to load the rest of our code.

```ruby
# In spec/human_spec.rb
require "./human.rb"
```

And that is it. We write not a single line of code more than we need to make the current error we're seeing go away.

Quick side note: the results we're seeing here are not that pretty. For the future, run rspec like this for prettier results:

```ruby
# In Terminal
rspec -fd -c
```
In these results, we can clearly see the tests we wrote being displayed in yellow and marked as PENDING, because we haven't actually written them yet.

Let the TDD begin:

**1)** Write a failing test!

```ruby
# In spec/human_spec.rb
describe Human do
  context 'Before breakfast a Person' do
    it 'should be hungry' do
      expect(Human.new.tummy).to eq('hungry')
    end
    it 'should be sleepy'
    it 'should be awake after drinking coffee'
    it 'should not be hungry after drinking coffee'
  end
end
```

**2)** Verify it fails! ..check! (Red)

`undefined method 'tummy' for #<Human:0x007fdf3a9798b8>`

**3)** Write some code to make it pass!

   We got an undefined method error, so let's define that method.

```ruby
# In human.rb
class Human
  attr_accessor :tummy
end
```

**4)** Run them tests! (Green?) ..nope!

```sh
Failure/Error: expect(Human.new.tummy).to eq('hungry')

       expected: "hungry"
            got: nil
```
Our tummy method is not returning "hungry". Our test expects tummy to be hungry right after the object is initialized, so:

**3)** Write some code to make it pass!

```ruby
class Human
  attr_accessor :tummy
  def initialize
    @tummy = "hungry"
  end
end
```

**4)** Run them tests! (Green?) ...yup!

**5)** Refactor code or tests (Refactor!)

    I don't see anything to complex or wet, we're good to continue!

**1)** Write a failing test!

```ruby
# In spec/human_spec.rb
it 'should be sleepy' do
  expect(Human.new.state).to eq('sleepy')
end
```

**2)** Verify they fail... check! (Red)

`undefined method 'state' for #<Human:0x007ff7f31bebd8 @tummy="hungry">`

**3)** Write some code to make it pass!

We already went through a very similar process, so this time we can know exactly what we're doing.

```ruby
# in Human.rb
class Human
  attr_accessor :tummy, :state
  def initialize
    @tummy = "hungry"
    @state = "sleepy"
  end
end
```

**4)** Run them tests! (Green?).. yep!

**5)** Refactor code or tests (Refactor!)

This time, I see some wetness appearing in our tests. We have the power of `before` blocks that run before every example:

```ruby
# In spec/human_spec.rb
before(:each) do
  @new_human = Human.new
end
it 'should be hungry' do
  expect(@new_human.tummy).to eq('hungry')
end
it 'should be sleepy' do
  expect(@new_human.state).to eq('sleepy')
end
```

`before` is just a method call that takes an option (either `:all` or `:each`), and a block. RSpec will then run this block once before each example in that `context`. This helps us do any setup we need for multiple examples. And let's us trim down the examples to be _only what is necessary_ to test what they need to test.

Later on you'll notice as well that `before` blocks are usually closely tied to the description of a `context`.

Note that we had to create instance variables. Our before block runs before every example, but not in the same scope. They are, however in the same _instance_ so they share instance variables.

Also, we see these two "after drinking coffee" tests, it doesn't make sense that they take place in the "before breakfast" context. Let's add a new context to describe that behavior.

```ruby
# In spec/human_spec.rb
context "After coffee a Person" do
  it 'should be awake after drinking coffee'
  it 'should not be hungry after drinking coffee'
end
```

Run the tests to verify that everything works. And we might see some opportunities to rename our tests as well.

```ruby
# In spec/human_spec.rb
context "After coffee a Person" do
  it 'should be awake'
  it 'should not be hungry'
end
```

...Everything is looking much better now!

**1)** Write a failing test!

We want our human to 1) have breakfast and then they should 2) be awake.

```ruby
# In spec/human_spec.rb
it 'should be awake' do
  human = Human.new
  human.get_coffee
  expect(human.state).to eq('awake')
end
```

**2)** Verify they fail... check! (Red)

`undefined method 'get_coffee' for #<Human:0x007fdbd89f60a8 @tummy="hungry", @state="sleepy">`

**3)** Write some code to make it pass!

By this time we should be pros at handling undefined method errors:

```ruby
# In human.rb
def get_coffee
end
```

**4)** Run them tests! (Green?) ..nope!

```sh
Failure/Error: expect(human.state).to eq('awake')

       expected: "awake"
            got: "sleepy"
```

**3)** Write some code to make it pass!

We see that after having called `get_coffee`, our human should now be awake. So let's make that so:

```ruby
# In human.rb
def get_coffee
  @state = "awake"
end
```

**4)** Run them tests! (Green?) ..yup!

**5)** Refactor? don't see any wetness anywhere.

**1)** Write a test!

```ruby
# In spec/ruby.rb
it 'should not be hungry' do
  human = Human.new
  human.get_coffee
  expect(human.tummy).to_not eq('hungry')
end
```

**2)** Verify it fails! (Red) ..yup!

```sh
Failure/Error: expect(human.tummy).to_not eq('hungry')

       expected: value != "hungry"
            got: "hungry"
```

**3)** Write some code that makes it pass!

We see that after having called `get_coffee`, our human should now be anything but hungry. So let's make that so:

```ruby
def get_coffee
  @state = "awake"
  @tummy = "satisfied"
end
```

**4)** Run them tests! (Green?) ..yup!

  BAM! We've successfully implemented all the behavior we planned for. There's still one last step though:

**5)** Refactor? I definitely see some wetness in our test:

```ruby
# In spec/human_spec.rb
before(:each) do
  @human = Human.new
  @human.get_coffee
end
it 'should be awake' do
  expect(@human.state).to eq('awake')
end
it 'should not be hungry' do
  expect(@human.tummy).to_not eq('hungry')
end
```

Everything looks good!

### In Retrospect
TDD is a process that I personally turn to when I'm building something too big to wrap my head around. Complex products can have hundreds of files and classes working together, no matter how senior the developer, it's near impossible to keep track of all of this in your head.

Tests serve as a way to direct your attention to only the piece that is the "next step", the one piece that is causing trouble at that moment, whether because a Class or method is not yet defined, or an existing method is not doing something you want it to do.

Tests find the next error you will encounter and present them to you, your job is to go through an fix them _one_ at a time. If you've ever felt frozen as to where to start or what comes next, tests do exactly that.

This may not seem so useful now, but as you approach Rails projects that have dozens of files working together, you know where to turn for guidance.
