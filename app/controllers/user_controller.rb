class UserController < ApplicationController

    get '/users' do
        erb :index  
    end

    get '/users/:slug' do 

        @user = User.find_by_slug(params[:slug])
        @posts = post.all.filter{|post| post.user_id == @user.id}
        erb :"users/show"
    end

    get '/users/:slug/edit' do
        redirect_if_not_logged_in
        account = User.find_by_slug(params[:slug])
        redirect_if_not_current_user(account)
        @user = current_user
        erb :"users/edit"
    end

    delete '/users/:slug/delete' do 
        redirect_if_not_logged_in
        account = User.find_by_slug(params[:slug])
        redirect_if_not_current_user(account)
        @user = current_user
        @user.delete
        redirect to "/"
    end

    patch '/users/:slug' do 
        redirect to "/users/:#{params[:slug]}/edit" if params[:user][:username].empty? || params[:user][:password].empty? || params[:user][:email].empty?
        @user = user.find(params[:slug])
        @user.update(params[:user])
        @user.save
        redirect to "/home"
    end
    
end 