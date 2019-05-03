class GenreController < ApplicationController

  get '/genres/:slug' do
    @current_user = Helpers.current_user(session)
    @genre = Genre.find_by_slug(params[:slug])
    erb :'/genres/show'
  end

end
