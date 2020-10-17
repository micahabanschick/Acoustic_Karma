class PostController < ApplicationController

    get '/posts' do 
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user
        @posts = Post.all.filter{|post| post.user_id == @user.id}.sort_by{|post| post.date_posted}.reverse
        erb :"posts/index"
    end 

    get '/posts/new' do 
        redirect_if_not_logged_in
        erb :"posts/new"
    end

    post '/posts' do 
        redirect_if_not_logged_in
        redirect to '/posts/new' if params[:post][:content].empty?
        @user = current_user
        @post = Post.create({content: params[:post][:content], user_id: @user.id, date_posted: Time.now.strftime("%Y-%m-%d %H:%M:%S")})
        # @post.date_posted = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        redirect to "/posts/#{@post.id}"
        # redirect to "/posts/#{@post.id}"
    end 

    get '/posts/:id/edit' do
        @post = Post.find(params[:id])
        @user = User.find(@post.user_id)
        redirect_if_not_current_user(@user)
        erb :"posts/edit"
        # erb :"posts/edit"
    end

    delete '/posts/:id/delete' do 
        post = Post.find(params[:id])
        user = User.find(post.user_id)
        redirect_if_not_current_user(user)
        post.delete
        post = nil
        redirect to "/"
        # erb :"posts/delete"
    end
    
    get '/posts/:id' do  
        @post = Post.find(params[:id])
        @user = User.find(@post.user_id)
        redirect_if_not_current_user(@user)
        erb :"posts/show"
    end

    patch '/posts/:id' do 
        redirect to "/posts/#{params[:id]}/edit" if params[:post][:content].empty?
        @post = Post.find(params[:id])
        @post.update(params[:post])
        @post.save 
        redirect to "/home"
    end

end 