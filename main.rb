require 'sinatra'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("warehouse_manager.db")
require_relative "models/category_class.rb"
require_relative "models/product_class.rb"
require_relative "models/location_class.rb"
require_relative "models/module.rb"
require_relative "models/class_module.rb"

DATABASE.results_as_hash = true

# working on getting rid of these
before do
  @name = "#{params["name"]}"
  @quantity = "#{params["quantity"]}"
  @description = "#{params["description"]}"
  @serial_num = "#{params["serial_num"]}"
  @cost = "#{params["cost"]}"
  @category_id = "#{params["category_id"]}"
  @location_id = "#{params["location_id"]}"
  @location_name = "#{params["location_name"]}"
  @update_location_name = "#{params["update_location_name"]}"
end

# Home Page

get "/" do
  erb :index, :layout => :boilerplate
end

# Updating the Product, Nav line 1

get "/add_product" do
  @title = "Add a product"
  logger.info params
  erb :add_product, :layout => :boilerplate
end

get "/update_product" do
  logger.info params
  erb :update_product, :layout => :boilerplate
end

get "/delete_product" do
  logger.info params
  erb :delete_product, :layout => :boilerplate
end

# Viewing product info, Nav line 2

get "/product_info" do
  erb :product_info, :layout => :boilerplate
end

get "/products_in_category" do
  erb :products_in_category, :layout => :boilerplate
end

get "/products_in_location" do
  logger.info params
  erb :products_in_location, :layout => :boilerplate
end
  
# Location information, Nav line 3

get "/add_location" do
  erb :add_location, :layout => :boilerplate
end

get "/update_location" do
  erb :update_location, :layout => :boilerplate
end

get "/delete_location" do
  erb :delete_location, :layout => :boilerplate
end  

# Completed Routes for Product

# working...adds the object, sends off to confirm.
get "/complete_product_add" do
  @name = params["name"]
  @description = params["description"]
  @quantity = params["quantity"]
  @serial_num = params["serial_num"]
  @cost = params["cost"]
  @category_id = params["category_id"]
  @location_id = params["location_id"]
  a = Product.new({"name"=>"#{@name}", "quantity"=>"#{@quantity}",
      "description"=>"#{@description}", "serial_num"=>"#{@serial_num}", "cost"=>"#{@cost}",
      "category_id"=>"#{@category_id}", "location_id"=>"#{@location_id}"})
  erb :complete_product_add, :layout => :boilerplate 
end

# working
get "/complete_delete_product" do
  logger.info params
  d = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>"#{@serial_num}"}) 
  Product.delete_record({"table"=>"products", "record_id"=>d})
  erb :complete_delete_product, :layout => :boilerplate
end

# TODO not working
get "/complete_product_update" do
  @serial_num = params["serial_num"]
  @category_name = params["category_name"]
  @location_name = params["location_name"]
  @name = params["name"]
  @quantity = params["quantity"]
  @desciption = params["description"]
  @cost = params["cost"]
  category_id = Category.find_record_id({"table"=>"categories", "field"=>"name", "value"=>"#{@category_name}"})
  location_id = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{@location_name}"})
  c = Product.new({"name"=>"#{@name}", "quantity"=>"#{@quantity}", 
      "description"=>"#{@description}", "serial_num"=>"#{@serial_num}", "cost"=>"#{@cost}", 
      "category_id"=>"#{category_id}", "location_id"=>"#{location_id}"}) 
  
  
  
  erb :complete_prduct_update, :layout => :boilerplate
end

# Completed routes for product info

# TODO not working
get "/complete_product_info" do
  @sn = params["serial_num"]
  d = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>@sn})
  g = Category.return_category_id(d)
  h = Category.return_category_name(g)
  i = Location.return_location_id(d)
  j = Location.return_location_name(i)
  @product_info = Product.find({"table"=>"products", "record_id"=>d}) + " Category: #{h}" + " Location: #{j}"
  erb :complete_product_info, :layout => :boilerplate
end

# TODO not working
get "/complete_products_in_location" do
  @location_name = params["location_name"]
  @f = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{@location_name}"})
  erb :complete_products_in_location, :layout => :boilerplate
end

# TODO not working
get "/complete_products_in_category" do
  @category_name = params["category_name"]
  @e = Category.find_record_id({"table"=>"categories", "field"=>"name", "value"=>"#{@category_name}"})
  
  erb :complete_products_in_category, :layout => :boilerplate
end

# Completed routes for location stuff

# working
get "/complete_location_add" do
  @n = params["location_name"]
  @d = params["description"]
  k = Location.new({"name"=>"#{@n}", "description"=>"#{@d}"}) 
  k.insert  
  erb :complete_location_add, :layout => :boilerplate
end

# TODO not working
get "/complete_location_update" do
  @nn = params["update_location_name"]
  @n = params["location_name"]
  @d = params["description"]
  l = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{@n}"})
  m = Location.new({"name"=>"#{@nn}", "description"=>"#{@d}"}) 
  m.save({"table"=>"locations", "item_id"=>l})  
  erb :complete_location_update, :layout => :boilerplate
end

# working
get "/complete_location_delete" do
  @n = params["location_name"]
  z = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{@n}"})
  Location.delete_record({"table"=>"locations", "record_id"=>z})
  erb :complete_location_delete, :layout => :boilerplate
end

# Confirmed info pages...inserting info into database.

# working. inserts product into table.
get "/confirmed_product_add" do
  DATABASE.execute("INSERT INTO products (name, description, quantity, serial_num, cost, category_id, location_id) VALUES
                  ('#{@name}', '#{@description}', '#{@quantity}', '#{@serial_num}', '#{@cost}', '#{@category_id}', '#{@location_id}')")
  @id = DATABASE.last_insert_row_id
  erb :confirmed_product_add, :layout => :boilerplate
end
