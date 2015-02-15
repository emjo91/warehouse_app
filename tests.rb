require 'sqlite3'
require 'pry'
require 'minitest/autorun'

require_relative "models/category_class.rb"
require_relative "models/product_class.rb"
require_relative "models/location_class.rb"
require_relative "models/module.rb"
require_relative "models/class_module.rb"

DATABASE = SQLite3::Database.new("test_database.db")

DATABASE.execute("DROP TABLE 'products'")
DATABASE.execute("DROP TABLE 'locations'")
DATABASE.execute("DROP TABLE 'categories'")


DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
                                                       quantity INTEGER, cost INTEGER, description TEXT,
                                                       serial_num INTEGER UNIQUE, category_id INTEGER, location_id INTEGER, 
                                                       FOREIGN KEY(category_id) REFERENCES categories(id),
                                                       FOREIGN KEY(location_id) REFERENCES locations(id))")
 

class WarehouseTest < Minitest::Test
  
  def test_create_new_product
    test_product = Product.new({"serial_num"=>93728, "description"=>"You know what the world needs? 
    More games centered on Elizabethan-era gem merchants.", "quantity"=>47, "name"=>"Splendor", 
    "cost"=>2799, "location_id"=>1, "category_id"=>1})
    x = test_product.insert
    assert_kind_of(Integer, x)
    # DATABASE.execute("DELETE FROM products WHERE name = 'Spendor'")
  end
  
  def test_create_new_location
    test_location = Location.new({"name"=>"Room 3", 
    "description"=>"Scattered against the walls"})
    x = test_location.insert
    assert_kind_of(Integer, x)
    # DATABASE.execute("DELETE FROM locations WHERE name = 'Room 3'")
  end
  
  def test_create_new_category
    test_category = Category.new({"name"=>"90s-00s toys", 
    "description"=>"Old things you may or may not remember."})
    x = test_category.insert
    assert_kind_of(Integer, x)
    # DATABASE.execute("DELETE FROM categories WHERE name = '90s-00s toys'")
  end
  
end
  