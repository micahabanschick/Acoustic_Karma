require "rack-flash"

class SongController < ApplicationController
    
    use Rack::Flash

    get '/songs' do 
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user
        @songs = Song.all.filter{|song| song.user_id == @user.id}.sort_by{|song| song.release_date}.reverse
        erb :"songs/index"
    end 

    get '/songs/new' do 
        redirect_if_not_logged_in
        @genres = Genre.all 
        erb :"songs/new"
    end

    post '/songs' do 
        redirect_if_not_logged_in
        redirect to '/songs/new' if params[:song][:name].empty?
        params[:song]["genre_ids"] = [] if !params[:song].keys.include?("genre_ids")
        @user = current_user
        @song = Song.create(params[:song])
        @song.user_id = @user.id
        @song.release_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        # @song = Song.create({name: params[:song][:name], user_id: @user.id, release_date: Time.now.strftime("%Y-%m-%d %H:%M:%S")})
        # @song.date_songed = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        flash[:message] = "Successfully created song."
        redirect to "/songs/#{@song.id}"
        # redirect to "/songs/#{@song.id}"
    end 

    get '/songs/:id/edit' do
        @song = Song.find(params[:id])
        @user = User.find(@song.user_id)
        redirect_if_not_current_user(@user)
        erb :"songs/edit"
        # erb :"songs/edit"
    end

    delete '/songs/:id/delete' do 
        song = Song.find(params[:id])
        user = User.find(song.user_id)
        redirect_if_not_current_user(user)
        song.delete
        song = nil
        redirect to "/"
        # erb :"songs/delete"
    end
    
    get '/songs/:id' do  
        @song = Song.find(params[:id])
        @user = User.find(@song.user_id)
        redirect_if_not_current_user(@user)
        erb :"songs/show"
    end

    patch '/songs/:id' do 
        redirect to "/songs/#{params[:id]}/edit" if params[:song][:name].empty?
        params[:song]["genre_ids"] = [] if !params[:song].keys.include?("genre_ids")
        @song = Song.find(params[:id])
        @song.update(params[:song])
        @song.save 
        flash[:message] = "Successfully updated song."
        redirect to "/songs/#{@song.id}"
    end

end 