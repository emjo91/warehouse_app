require 'sinatra'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("warehouse_manager.db")
require_relative 'category_class.rb'
require_relative 'product_class.rb'
require_relative 'location_class.rb'
require_relative 'module.rb'
require_relative 'class_module.rb'



# Before Filter

before do
  @name = "#{params["name"]}"
  @quantity = "#{params["quantity"]}"
  @description = "#{params["description"]}"
  @serial_num = "#{params["serial_num"]}"
  @cost = "#{params["cost"]}"
  @category_id = "#{params["category_id"]}"
  @location_id = "#{params["location_id"]}"
end

# Home Page

get "/" do
  erb :index, :layout => :boilerplate
end

# Updating the Product, Nav line 1

get "/add_product" do
  logger.info params
  erb :add_product, :layout => :boilerplate
end

get "/update_product" do
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

# Completed Routes

get "/complete_product_add" do
  logger.info params
  a = Product.new({"name"=>"#{@name}", "quantity"=>"#{@quantity}", 
      "description"=>"#{@description}", "serial_num"=>"#{@serial_num}", "cost"=>"#{@cost}", 
      "category_id"=>"#{@category_id}", "location_id"=>"#{@location_id}"})
      a.insert
  erb :complete_product_add, :layout => :boilerplate
end

get "/complete_delete_product" do
  logger.info params
  d = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>"#{@serial_num}"}) 
  Product.delete_record({"table"=>"products", "record_id"=>d})
  erb :complete_delete_product, :layout => :boilerplate
end
