
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @params=params["post"]
    name = params[:name]
    content = params[:content]
    Post.create(name: name, content: content)

    redirect to '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id].to_i)
    erb :edit
  end
  patch '/posts/:id' do
    post = Post.find(params[:id].to_i)
    post.update(name: params[:name])
    post.update(content: params[:content])
    post.save
    redirect to '/posts/'+post.id.to_s
  end
end
