require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
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
        erb :login
    end

    post '/home' do 
        # binding.pry 
        @user = User.new(params["user"])
        # @password = params["user"][:password]
        # @username = params["user"][:username]
        erb :home 
    end 

    helpers do
        
        def redirect_if_not_logged_in
          if !logged_in?
            redirect "/login?error=You have to be logged in to do that"
          end
        end
    
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
    
    end

end
