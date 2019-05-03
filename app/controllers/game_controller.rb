class GameController < ApplicationController

  get '/games/new' do
    @current_user = Helpers.current_user(session)
    @genres = Genre.all
    @developers = Developer.all
    if Helpers.is_logged_in?(session)
      erb :'/games/new'
    else
      redirect '/'
    end

  end

  get '/games/:slug' do
    @current_user = Helpers.current_user(session)
    @game = Game.find_by_slug(params[:slug])
    if @game
      erb :'/games/show'
    else
      redirect '/'
    end
  end

  get '/games/:slug/edit' do
    @current_user = Helpers.current_user(session)
    @genres = Genre.all
    @developers = Developer.all
    @game = Game.find_by_slug(params[:slug])
    if @game && @current_user.games.include?(@game)
      erb :"/games/edit"
    else
      redirect '/'
    end
  end

  post '/mod_game/:slug' do
    @game = Game.find_by_slug(params[:slug])
    @current_user = Helpers.current_user(session)
    if params[:mod_game] == "Add_to_Library"
      @current_user.games << @game
      @current_user.save
    else
      redirect "/games/#{@game.slug}/edit"
    end
  end

  post '/games' do
    @current_user = Helpers.current_user(session)
    @game = Game.new(params[:game])
    @current_user.games << @game
    @game.genre_ids = params[:genres]
    @game.developer_id = params[:developer]
    if params[:new_genre] != nil && !params[:new_genre].empty?
      genre = Genre.create({name: params[:new_genre]})
      @game.genre_ids << genre.id
    end
    if params[:new_dev] != nil && !params[:new_dev].empty?
      developer = Developer.create({name: params[:new_dev]})
      @game.developer = developer
    else
      @game.developer_id = params[:developer]
    end
    if !(!!@game.developer && !!@game.genres && !!@game.name)
      redirect "/games/new"
    else
      @current_user.save
      @game.save
      redirect "/games/#{@game.slug}"
    end

  end

  patch '/games/:slug' do
    @current_user = Helpers.current_user(session)
    @game = Game.find_by_slug(params[:slug])
    @game.update(params[:game])
    @game.genre_ids = params[:genres]
    if params[:new_genre] != nil && !params[:new_genre].empty?
      genre = Genre.create({name: params[:new_genre]})
      @game.genre_ids << genre.id
    end
    if params[:new_dev] != nil && !params[:new_dev].empty?
      developer = Developer.create({name: params[:new_dev]})
      @game.developer = developer
    else
      @game.developer_id = params[:developer]
    end
    if !(!!@game.developer && !!@game.genres && !!@game.name)
      redirect "/games/new"
    else
      @game.save
      redirect "/games/#{@game.slug}"
    end

  end




end
