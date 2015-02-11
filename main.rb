require 'sinatra'


get "/" do
  erb :index, :layout => :boilerplate
end

# Updating the Product, Nav line 1

get "/add_product" do
  erb :add_product, :layout => :boilerplate
end

get "/update_product" do
  erb :update_product, :layout => :boilerplate
end

get "/delete_product" do
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
  
# Other random files

get "/completed" do
  erb :completed, :layout => :boilerplate
end