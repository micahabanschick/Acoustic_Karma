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
        erb :login
    end

    post '/home' do 
        # binding.pry 
        @user = User.new(params["user"])
        # @password = params["user"][:password]
        # @username = params["user"][:username]
        erb :home 
    end 

end
