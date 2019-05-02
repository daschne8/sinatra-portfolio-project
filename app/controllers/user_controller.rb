class UserController < ApplicationController

  get '/' do
    @current_user = User.find_by_id(session[:user_id])
    @games = Game.all
    @developers = Developer.all
    @users = User.all
    @genres = Genre.all
    erb :index
  end

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'users/login'
  end

  get "/users/:slug" do
    @current_user = User.find_by_slug(params[:slug])
    @games = @current_user.games.uniq
    @developers = @current_user.developers.uniq
    @genres = @current_user.genres.uniq
    erb :'users/homepage'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      redirect '/login'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      redirect '/signup'
    end

  end

end
