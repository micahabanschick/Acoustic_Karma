class User 

    # attr_accessor :u_name, :p_word
    @@all = []

    def initialize(args)
        # @u_name = args['username']
        # @p_word = args[:password]
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