require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'

enable :sessions

get '/' do
	@posts = Post.order(created_at: :desc)
	@title = "Welcome"
	erb :'posts/index'
end

get '/posts/create' do
	@title = 'Create New Post'
	@post = Post.new
	erb :'posts/create'
end

get '/posts/:id' do
	@post = Post.find(params[:id])
	@title = @post.title
	erb :'posts/view'
end

post "/posts" do
	@post = Post.new(params[:post])
	if @post.save
		redirect "posts/#{@post.id}", notice: "Congrats!"
	else
		erb :"posts/create", error: "Please fill all the fields"
	end
end

class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true
end

helpers do
	def title
		@title ? "#{@title}" : "Welcome"
	end
end