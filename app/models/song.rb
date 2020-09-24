class Song < ActiveRecord::Base
    belongs_to :user
    belongs_to :album
    has_many :song_genres
    has_many :genres, through: :song_genres
end