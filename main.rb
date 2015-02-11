require 'sinatra'

get "/" do
  erb :index, :layout => :boilerplate
end

get "/add_product" do
  erb :add_product, :layout => :boilerplate
end

get "/completed" do
  erb :completed, :layout => :boilerplate
end