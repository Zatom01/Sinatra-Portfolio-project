require './config/environment'


class ApplicationController < Sinatra::Base

  # config.time_zone = 'Pacific Time (US & Canada)'
  # config.active_record.default_timezone = :local
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Producer.find(session[:user_id])
    end


    # def redirect_if_not_logged_in
    #   if !logged_in?
    #     redirect "/login"
    #   end
    # end

    # def redirect_if_logged_in
    #   if logged_in?
    #     redirect "/posts"
    #   end
    # end


  end

end
