class User 

    attr_accessor :username, :password
    @@all = []

    def initialize(args)
        @username = args['username']
        @password = args[:password]
        self.save 
    end

    def save
        @@all << self
    end

    def self.all 
        @@all 
    end
    
    def self.clear 
        @@all = []
    end

end 