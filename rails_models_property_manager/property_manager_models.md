# Property Manager Models
Last time, you created your `Property` model. That's great, but your app takes care of quite a bit more than that! Time to start building the rest!

## Walkthrough

Go back to your Property Manager app. You're about to prepare the other models for the app so they match the ERD you designed in the previous exercise.

Change directories to the `property_manager` folder and open it in your text editor.

There's a handy gem called `rails-erd` that generates a PDF document containing an ERD of your current database. Install it so you can visualize your work as you go along:

In your `Gemfile`...

```ruby
group :development do
  gem "rails-erd"
end
```

In the console:

```
bundle install
brew install graphviz
```

You now have a new *Rake task* in your application, thanks to our good friend `rails-erd`. To use it to generate an up-to-date ERD, run:

```
rake erd
```

Done! Now there's an `ERD.pdf` in your app's directory.

In your terminal:

```
open erd.pdf
```

At this point you should only have one table (`properties`) in your database. Let's get to work generating the other models.

Up until now, youve been creating the columns of your tables through migrations, but we can also do this quickly straight from when you generate your model. Here's the syntax:

```
rails g model Landlord name
```

Run `rake db:migrate` to run the generated migration. If you'd like, you can create a new ERD to see the new model. You'll notice they aren't connected in any way yet!

It's time to connect the Landlords and Properties! Because you can say a landlord _has many_ properties, and each property _belongs to_ a landlord, it seems appropriate that a `has_many` and `belongs_to` association should be used here. First, open your `landlord.rb` file in your `app/models` folder. Let Rails know that Landlords have many properties:

```ruby
class Landlord < ActiveRecord::Base
  has_many :properties
end
```

Add the other end of the relationship to your `Property` model. In `property.rb`:

```ruby
class Property < ActiveRecord::Base
  belongs_to :landlord
end
```

Now, as we know, `has_many` and `belongs_to` need a foreign key column to link the child to the parent. Each `Property` needs a `landlord_id` column to enable our database to know which landlord each property belongs to.

Normally, this is where you would generate an empty migration and write some code inside it. Turns out, we've been keeping a secret from you. If you correctly name your migration, like `AddThingToModel`, you can actually add other arguments for the columns you want to add and what type they are, and Rails will automatically create that migration. This time, create the migration purely from the command line:

```
rails g migration AddLandlordToProperties landlord_id:integer
```

Go check the migration file to make sure you generated the correct migration. Does the `change` method look familiar? It should be pretty much identical to how you've been doing it manually up until now.

Before you migrate, let us teach you something else. Use `rails d migration AddLandlordToProperties` to remove the last migration. (we can remove the last migration because we haven't run it yet, but **don't delete migrations once they've been run**) 

ActiveRecord knows what foreign keys are, and it has special protections in place for certain things. For example, if you delete a landlord, you'd also want to delete all of his properties, otherwise you'll be stuck with orphaned properties scattered in your database.

Instead of an ordinary `integer`, we can tell ActiveRecord this is a foreign key for a `belongs_to` association. The column will still be an integer, but there will be other protections in place as well. Run this in your terminal instead:

```
rails g migration AddLandlordToProperties landlord:belongs_to
```
or 

```
rails g migration AddLandlordToProperties landlord:references
```

Both do the same thing. If you check the newly created migration, you'll note that ActiveRecord is refering to this column as a _reference_. This makes sense! It's referencing a landlord. It's good practice to use this for all your foreign key needs. (Once you run the migration, you can check your schema to see that the column created is still `landlord_id`, but there are some extra restraints in place for this foreign key).

If everything looks good, `rake db:migrate` to execute these migrations. Check the `schema` and you should see the necessary columns.

Great! There's one more model that need's to be generated: repairs. You are on your own for this one. Make sure to think about the relationship between and properties and repairs and what columns will be necessary in the repair model.

Run the `rake erd` command to verify that you've correctly build your app to the ERD you planned.

Compare the erd.pdf to your initial drawing, then compare it to your schema file. You've modeled your first app!
