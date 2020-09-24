class Album < ActiveRecord::Base
    belongs_to :user 
    has_many :songs 
    has_many :genres, through: :songs
end