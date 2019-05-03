class DeveloperController < ApplicationController

  get '/developers/:slug' do
    @current_user = Helpers.current_user(session)
    @developer = Developer.find_by_slug(params[:slug])
    erb :'/developers/show'
  end

end
