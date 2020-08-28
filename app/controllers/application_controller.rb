require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/' do 
        # erb :index
        username ||= nil 
        password ||= nil 
        if username == nil && password == nil 
            redirect '/login'
        else
            redirect '/home'
        end 
    end

    get '/login' do
        erb :login
    end

    post '/home' do 
        p = params
        erb :home 
    end 

end
