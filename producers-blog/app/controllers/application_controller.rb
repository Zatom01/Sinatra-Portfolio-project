require './config/environment'


class ApplicationController < Sinatra::Base

  # config.time_zone = 'Pacific Time (US & Canada)'
  # config.active_record.default_timezone = :local
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
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
  end


    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors]="Choose different username/email while signup or you must be logged in to view the page"
        redirect "/login"
      end
    end
end
