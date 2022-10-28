# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY;


INSERT INTO items (name, price, quantity) VALUES ('Apple', 20, 5);
INSERT INTO items (name, price, quantity) VALUES ('Ball', 200 , 1);
INSERT INTO items (name, price, quantity) VALUES ('Chair', 7000, 10);
INSERT INTO items (name, price, quantity) VALUES ('Discoball', 2000, 0);
INSERT INTO items (name, price, quantity) VALUES ('Eggs', 150, 35);

INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Anna', '2022-10-25', 1);
INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Bob', '2022-10-26', 3);
INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Clara', '2022-10-26', 1);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Item
end

class Order
end
# Repository class
# (in lib/student_repository.rb)
class ShopRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Item
  attr_accessor :id, :name, :price, :quantity
end

class Order
  attr_accessor :id, :customer_name, :date_placed, :item_id
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ShopRepository

  # Selecting all records
  # No arguments
  def all(table)
    # Executes the SQL query:

    # Returns an array of objects from given array.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def create_item(item)
    # Executes the SQL query:

    # Creates new instance of item.
  end

  def create_order(order)
    # Executes the SQL query:

    # Creates new instance of order.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = ShopRepository.new

items = repo.all(items)

expect(items.length).to eq 5
expect(items[0].name).to eq 'Apple'
expect(items[4].id).to eq 5
expect(items[2].quantity).to eq 10

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_library_test' })
  connection.exec(seed_sql)
end

describe ShopRepository do
  before(:each) do 
    reset_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
