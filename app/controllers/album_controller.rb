class AlbumController < ApplicationController

    get '/albums' do 
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user
        @albums = Album.all.filter{|album| album.user_id == @user.id}.sort_by{|album| album.release_date}.reverse
        erb :"albums/index"
    end 

    get '/albums/new' do 
        redirect_if_not_logged_in
        erb :"albums/new"
    end

    post '/albums' do 
        redirect_if_not_logged_in
        redirect to '/albums/new' if params[:album][:name].empty?
        @user = current_user
        @album = Album.create({name: params[:album][:name], user_id: @user.id, release_date: Time.now.strftime("%Y-%m-%d %H:%M:%S")})
        # @album.date_albumed = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        redirect to "/albums/#{@album.id}"
        # redirect to "/albums/#{@album.id}"
    end 

    get '/albums/:id/edit' do
        @album = Album.find(params[:id])
        @user = User.find(@album.user_id)
        redirect_if_not_current_user(@user)
        erb :"albums/edit"
        # erb :"albums/edit"
    end

    delete '/albums/:id/delete' do 
        album = Album.find(params[:id])
        user = User.find(album.user_id)
        redirect_if_not_current_user(user)
        album.delete
        album = nil
        redirect to "/"
        # erb :"albums/delete"
    end
    
    get '/albums/:id' do  
        @album = Album.find(params[:id])
        @user = User.find(@album.user_id)
        redirect_if_not_current_user(@user)
        erb :"albums/show"
    end

    patch '/albums/:id' do 
        redirect to "/albums/#{params[:id]}/edit" if params[:album][:name].empty?
        @album = Album.find(params[:id])
        @album.update(params[:album])
        @album.save 
        redirect to "/home"
    end

end 