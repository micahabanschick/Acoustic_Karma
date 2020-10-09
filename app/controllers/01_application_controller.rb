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
        erb :login, :layout => :layout_signup
    end

    post '/home' do 
        # binding.pry 
        @user = User.new(params["user"])
        # @password = params["user"][:password]
        # @username = params["user"][:username]
        erb :home 
    end 

    post '/login' do
    # binding.pry
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/posts"
        else
            redirect to "/login"
        end     
    end 

    get '/signup' do 
        redirect_if_logged_in
        erb :signup, :layout => :layout_signup 
    end 

    post '/signup' do 
        redirect to '/signup' if params[:username].empty? || params[:password].empty? || params[:email].empty?
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to "/posts"
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
    
        def is_logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
    
    end

end