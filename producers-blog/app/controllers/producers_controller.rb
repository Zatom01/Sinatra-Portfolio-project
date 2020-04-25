class ProducersController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :'producers/login'
        else
            redirect '/posts'
        end
    end



    get '/signup' do
        if !logged_in?
            erb :'/producers/signup'
        else
            redirect '/posts'
        end
    end

    post '/login' do

        @producer= Producer.find_by(username: params[:username])
        if @producer && @producer.authenticate(params[:password])
            session[:user_id]=@producer.id
            redirect '/posts'
        else
            redirect '/login'
        end

    end

    post '/signup' do
        if !logged_in?
            if params[:username]=="" || params[:email]=="" || params[:password]==""
                redirect '/signup'
            else
                @producer=Producer.create(params)
                session[:user_id]=@producer.id
                redirect '/posts'
            end
        else
            redirect '/posts'
        end
    end

    get '/posts/:username' do
        if logged_in?
            if params[:username]==current_user.username
                @producer=current_user
                erb :'/producers/show'
            else
                redirect '/login'
            end
        else
            redirect '/login'
        end
    end


    get '/logout' do
        session.clear
        redirect '/login'
    end

end
