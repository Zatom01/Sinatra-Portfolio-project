
class PostsController < ApplicationController

    #  to the index page with all posts/movies
    get '/posts' do
        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=current_user
            @posts=Post.all.last(5)
            @movies=Movie.all.last(5)
            erb :'posts/index'
        end
    end

    get '/posts/newpost' do
        @producer=current_user
        if !logged_in?
            rredirect_if_not_logged_in
        else

            erb :'/posts/new'
        end
    end

    post '/posts' do
        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=current_user
            @producer.posts << Post.create(params)
            redirect '/posts'
        end
    end

    get '/posts/:username/:postid/edit' do
        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=Producer.find_by(username: params[:username])
            @post=Post.find_by(id: params[:postid])
            if @post.producer=@producer
                erb :'posts/edit'
            else
                redirect '/login/'
            end
        end
    end

    patch '/posts/:username/:postid' do

        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=Producer.find_by(username: params[:username])
            @post=Post.find_by(id: params[:postid])
            if @producer==current_user
                if !!params[:update] && !params[:content].empty?
                    @post.update(:content=>params[:content])
                    redirect "/posts/:username"
                elsif params[:content].empty? && !!params[:delete]
                        @post.delete
                        redirect "/posts/:username"
                else
                    redirect "post/:username/:postid/edit"
                end
            else
                redirect "/login"
            end
        end

    end




end
