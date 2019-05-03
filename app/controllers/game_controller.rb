class GameController < ApplicationController

  get '/games/new' do
    @genres = Genre.all
    @developers = Developer.all
    erb :'/games/new'
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])
    if @game
      erb :'/games/show'
    else
      redirect '/'
    end
  end

  get '/games/:slug/edit' do
    @genres = Genre.all
    @developers = Developer.all
    @game = Game.find_by_slug(params[:slug])
    if @game
      erb :"/games/edit"
    else
      redirect '/'
    end
  end

  post '/games' do
    @current_user = Helpers.current_user(session)
    @game = Game.create(params[:game])
    @current_user.games << @game
    @game.genre_ids = params[:genres]
    @game.developer_id = params[:developer]
    @current_user.save
    @game.save

    redirect "/games/#{@game.slug}"
  end

  patch '/games/:slug' do
    @current_user = Helpers.current_user(session)
    @game = Game.find_by_slug(params[:slug])
    @game.update(params[:game])
    @game.genre_ids = params[:genres]
    @game.developer_id = params[:developer]
    @game.save

    redirect "/games/#{@game.slug}"
  end




end
