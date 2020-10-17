class UserController < ApplicationController
    get '/users' do
        erb :index  
    end
    
    get '/users/:slug' do 
        # binding.pry
        @user = User.find_by_slug(params[:slug])
        @posts = Post.all.sort_by{|post| post.date_posted}.reverse
        erb :home
    end

    get '/users/:slug/edit' do
        # redirect_if_not_logged_in
        @user = User.find_by_slug(params[:slug])
        redirect_if_not_current_user(@user)
        erb :"users/edit"
    end

    delete '/users/:slug/delete' do 
        # redirect_if_not_logged_in
        user = User.find_by_slug(params[:slug])
        redirect_if_not_current_user(user)
        user.delete
        user = nil
        session[:user_id] = nil
        redirect "/"
    end

    patch '/users/:slug' do 
        redirect to "/users/#{params[:slug]}/edit" if params[:user][:username].empty? || params[:user][:password].empty? || params[:user][:email].empty?
        @user = User.find_by_slug(params[:slug])
        @user.update(params[:user])
        @user.save
        redirect to "/home"
    end
    
end 