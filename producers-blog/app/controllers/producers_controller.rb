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
            flash[:message] = "You are now logged in"
            redirect '/posts'
        else
            flash[:message] = "Username/Password Invalid"
            redirect '/login'
        end

    end

    post '/signup' do
        if !logged_in?
            if params[:username]=="" || params[:email]=="" || params[:password]==""
                flash[:message] = "All fields need to be filled"
                redirect '/signup'
            else
                @producer=Producer.create(params)
                session[:user_id]=@producer.id
                flash[:message] = "You are now logged in"
                redirect '/posts'
            end
        else
            redirect '/posts'
        end
    end

    get '/posts/listusers' do
       @producers=Producer.all
       @currentproducer=current_user
       erb :'producers/listusers'
    end

    get '/posts/viewprofile/:username' do
        redirect_if_not_logged_in
        @currentproducer=current_user
        @producer=Producer.find_by(username: params[:username])
        @posts=@producer.posts.last(4).reverse
        @movies=@producer.movies.last(4).reverse
        if @producer==current_user
            @views=current_user.views
            erb :'producers/show'
        else
            @views=@producer.views + 1
            @producer.update(:views=>@views)
            erb :'/producers/viewprofile'
        end

    end

    get '/posts/:username' do
        if logged_in?
            if params[:username]==current_user.username
                @producer=current_user
                @posts=@producer.posts.last(5).reverse
                @movies=@producer.movies.last(5).reverse
                erb :'/producers/show'
            else
                redirect '/login'
            end
        else
            redirect_if_not_logged_in
        end
    end


    get '/logout' do
        session.clear
        flash[:message] = "You are now logged out"
        redirect '/login'
    end

end
