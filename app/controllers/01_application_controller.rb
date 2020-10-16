require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security" 
    end

    get '/' do
        redirect_if_not_logged_in
        redirect to "/home"  
    end

    get '/login' do
        redirect_if_logged_in
        erb :login, :layout => :layout_signin
    end

    get '/home' do 
        redirect_if_not_logged_in
        @user = current_user
        redirect to "/users/#{@user.slug}"
    end 

    post '/login' do
    # binding.pry
        params[:user][:username_or_email].include?("@") ? user = User.find_by(email: params[:user][:username_or_email]) : user = User.find_by(username: params[:user][:username_or_email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect to "/home"
        else
            redirect to "/login"
        end     
    end 

    get '/signup' do 
        redirect_if_logged_in
        erb :signup, :layout => :layout_signin 
    end 

    post '/signup' do 
        # binding.pry
        redirect to '/signup' if params[:user][:username].empty? || params[:user][:password].empty? || params[:user][:email].empty?
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect to "/home"
    end

    get '/logout' do 
        session[:user_id] = nil
        redirect to "/login"
    end

    helpers do

        def redirect_if_not_logged_in
          if !is_logged_in?
            redirect "/login?error=You have to be logged in to do that"
          end
        end

        def redirect_if_logged_in
            if is_logged_in?
              redirect "/home?error=You cannot be logged in to do that"
            end
        end

        def redirect_if_not_current_user(user)
            redirect_if_not_logged_in
            if current_user != user 
                redirect "/users/#{user.slug}?error=You cannot manipulate another user account"
            end
        end
    
        def is_logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
    
    end

end