class Helpers

    def self.current_user(session)
        User.find(session[:user_id])
    end 

    def self.is_logged_in?(session)
        !!session[:user_id]
    end 
        
    def redirect_if_not_logged_in(session)
        if !is_logged_in?(session)
            redirect "/login?error=You have to be logged in to do that"
        end
    end
    
end