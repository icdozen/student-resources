#Property Manager Migrations

Now that you and your teammate have planned out the ERD for the app that will make you the world's next startup billionaires, it's time to start building it! The second step of any app, after you finish the ERD, is to start building those models!

We'll walk you through the first few steps to get started.

## Walkthrough

Create a new rails app named `property_manager`.

Change directories into the new `property_manager` folder.

Open the app in your text editor using `atom .`

Once you have that open, go back to the terminal and generate a `Property` model, in accordance with your ERD:

`rails g model Property`

You know that you want to add some columns to your `properties` table to include a `location` and a `rent` for every property that a landlord owns. You can use migrations to make changes to a model that already exists.

Start by adding a `location` field. From the command line, generate an empty migration with proper naming conventions:

`rails g migration AddLocationToProperties`

You should now see a new migration in your migrations folder, `db/migrations`.

Open that migration in your text editor. You should see an empty `change` method.

Now, prepare the migration. Migrations are just instructions to make changes to the database. The code you add here are special instructions that ActiveRecord will use when we run the migration.

```ruby
def change
  add_column :properties, :location, :string
  add_column :properties, :rent, :string
end
```

Take a look at your schema, located at `db/schema.rb`. Notice that nothing has changed yet though.

You wrote the instructions, you just haven’t actually *carried them out*.

Run the migration you just wrote:

`rake:db migrate`

Now, go back and look at your schema again. The `properties` table should now have both `city` and `rent` fields, and they should both be strings.

You can also verify that everthing is working properly from Rails' console. Jump into `rails c` and try running:

`Property.column_names`

This should return an array including `"location"` and `"rent"`.

Great! You've made the first migration of your soon-to-be billion-dollar app!

Only, you've made a mistake! `location` is too vague, you should rename that column to `city`. Time to create another migration!

`rails g migration RenameLocationToCity`

Jump into that new migration to rename the column:

```ruby
def change
  rename_column :properties, :location, :city
end
```

`rake db:migrate` and check your schema.rb

Did the column rename successfully? Good!

Oops! You just realized that you made another mistake when you created the `rent` column of the properties table. The column is going to store money, and you made the column a String instead of an integer!

Make that change. Generate the migration on your own this time.

Once it's been generated, add the syntax for changing a column:

```ruby
def change
  change_column :properties, :rent, :integer
end
```

Migrate and verify that the change took place as expected by checking your schema.

Your property model is finished! At least it was, but now you get a call from your landlord co-founder. He "just realized" that the app should absolutely not track rent for vague legal reasons. Turns out we don't want that rent column at all.

On your own, look up the syntax and create the migration to remove the rent column. 

Migrate and check your schema, did it work?
