class GenreController < ApplicationController

    get '/genres' do 
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user
        songs = Song.all.filter{|song| song.user_id == @user.id}
        @genres = Song.all.map{|song| song.genres}.flatten
        erb :"genres/index"
    end 

    get '/genres/all' do 
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user
        @genres = Genre.all
        erb :"genres/index"
    end 

    get '/genres/new' do 
        redirect_if_not_admin(current_user)
        @songs = Song.all
        erb :"genres/new"
    end

    post '/genres' do 
        redirect_if_not_logged_in
        redirect to '/genres/new' if params[:genre][:name].empty?
        params[:genre]["song_ids"] = [] if !params[:genre].keys.include?("song_ids")
        redirect to '/genres/new' if params[:genre][:song_ids].empty?
        @user = current_user
        @genre = genre.create(params[:genre])
        @genre.user_ids << @user.id
        @genre.release_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        @genre.save
        redirect to "/genres/#{@genre.id}"
    end 

    get '/genres/:id/edit' do
        @genre = Genre.find(params[:id])
        @user = User.find(@genre.user_id)
        redirect_if_not_current_user(@user)
        erb :"genres/edit"
        # erb :"genres/edit"
    end

    delete '/genres/:id/delete' do 
        redirect_if_not_admin(current_user)
        genre = Genre.find(params[:id])
        genre.delete
        genre = nil
        redirect to "/user/#{current_user.slug}"
    end
    
    get '/genres/:id' do  
        @genre = Genre.find(params[:id])
        @user = current_user
        redirect_if_not_current_user(@user)
        erb :"genres/show"
    end

    patch '/genres/:id' do 
        redirect_if_not_admin(current_user)
        redirect to "/genres/#{params[:id]}/edit" if params[:genre][:name].empty?
        params[:genre]["song_ids"] = [] if !params[:genre].keys.include?("song_ids")
        @genre = genre.find(params[:id])
        @genre.update(params[:genre])
        @genre.save 
        redirect to "/genres/#{@genre.id}"
        # redirect to "/home"
    end

end 