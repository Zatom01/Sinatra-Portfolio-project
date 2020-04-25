class MoviesController < ApplicationController
    get '/posts/newmovie' do
        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=current_user
            erb :'/movies/new'
        end
    end

    post '/posts/newmovie' do
        if logged_in?
            current_user.movies << Movie.create(params)
            redirect '/posts'
        else
            redirect_if_not_logged_in
        end
    end

    get '/movies/:username/:movie_id/edit' do

        if !logged_in?
            redirect_if_not_logged_in
        else
            @producer=Producer.find_by(username: params[:username])
            @movie=Movie.find_by(id: params[:movie_id])
            if @producer == @movie.producer
                erb :'movies/edit'
            else
                redirect '/login'
            end
        end
    end

    patch '/movie-posts/:username/:movie_id' do
        if !logged_in?
            rredirect_if_not_logged_in
        else
            @producer=Producer.find_by(username: params[:username])
            @movie=Movie.find_by(id: params[:movie_id])
            if @producer==@movie.producer
                if !!params[:update] && !params[:name].empty?
                    @movie.update(:name=> params[:name])
                    flash[:message] = "Successfully updated movie name"
                    redirect '/posts/:username'
                elsif !!params[:delete] && params[:name].empty?
                    @movie.delete
                    flash[:message] = "Successfully deleted movie."
                    redirect '/posts/:username'
                end
            else
                redirect '/login'
            end
        end
    end
end
