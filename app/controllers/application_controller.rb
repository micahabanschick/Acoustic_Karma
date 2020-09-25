require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

    get '/' do 
        # erb :index
        @username ||= nil 
        @password ||= nil 
        if @username == nil && @password == nil 
            redirect '/login'
        else
            redirect '/home'
        end 
    end

    get '/login' do
        if !Helpers.is_logged_in?(session)
            erb :login  
        # else
            # redirect to "/tweets"
        end 
    end

    post '/home' do 
        # binding.pry 
        @user = User.new(params["user"])
        # @password = params["user"][:password]
        # @username = params["user"][:username]
        erb :home 
    end 

    
    get '/login' do
        if !Helpers.is_logged_in?(session)
            erb :login  
        else
            redirect to "/tweets"
        end 
    end

    post '/login' do
    # binding.pry
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/tweets"
        else
            redirect to "/login"
        end     
    end 

    get '/signup' do 
        if session[:user_id]#.empty? 
            redirect to "/tweets"
        # else  
            # erb :signup
        end
    end 

    post '/signup' do 
        redirect to '/signup' if params[:username].empty? || params[:password].empty? || params[:email].empty?
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to "/tweets"
    end

    get '/logout' do 
        session[:user_id] = nil
        redirect to "/login"
    end

end
