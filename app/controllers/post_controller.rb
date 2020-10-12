class PostController < ApplicationController

    get '/posts' do 
        # binding.pry
        if is_logged_in?#.empty?
            @user = current_user#User.find(session[:user_id])
            @posts = post.all#.filter{|post| post.user_id == @user.id}
            erb :"posts/index"
        else 
            redirect to "/login"
        end 
    end 

    get '/posts/new' do 
        if is_logged_in?
            erb :"posts/new"
        else 
            redirect to "/login"
        end 
    end

    post '/posts' do 
        @user = current_user
        if !params[:content].empty? 
            @post = post.create(content: params[:content], user_id: @user.id)
            redirect to "/posts/#{@post.id}"
        else
            redirect to "/posts/new"
        end
        # redirect to "/posts/#{@post.id}"
    end 

    get '/posts/:id/edit' do
        if is_logged_in?
            @post = post.find(params[:id])
            erb :"posts/edit"
        else 
            redirect to "/login"
        end 
        # erb :"posts/edit"
    end

    delete '/posts/:id/delete' do 
        @post = post.find(params[:id])
        if is_logged_in?
            @user = current_user
            @post.delete if @post.user_id == @user.id
            redirect to "/posts"
        else 
            redirect to "/login"
        end 
        # erb :"posts/delete"
    end
    
    get '/posts/:id' do  
        @post = post.find(params[:id])
        # is_logged_in? ? erb(:"posts/show") : redirect to "/login"
        if is_logged_in?
            erb :"posts/show"
        else 
            redirect to "/login"
        end 
    end

    patch '/posts/:id' do 
        @post = post.find(params[:id])
        if params[:content].empty?
            redirect to "/posts/#{@post.id}/edit"
        else 
            @post.content = params[:content]
            @post.save
            redirect to "/posts/#{@post.id}"
        end 
        # @post.content = params[:content]
        # @post.save
        # redirect to "/posts/#{@post.id}"
    end

    delete '/posts/:id' do 
        @post = post.find(params[:id])
        redirect to "/posts/index"
    end

end 