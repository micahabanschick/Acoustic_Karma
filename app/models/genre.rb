class Genre < ActiveRecord::Base
    has_many :users
    has_many :song_genres
    has_many :songs, through: :song_genres
end