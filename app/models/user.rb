class User < ActiveRecord::Base
    has_secure_password
    has_many :songs 
    has_many :genres, through: :songs 
    has_many :posts
    has_many :comments
    has_many :albums

    def slug
        self.username.downcase.split(" ").join("-")
      end
    
      def self.find_by_slug(slug)
        self.all.find{|user| user.slug == slug}
      end
end 