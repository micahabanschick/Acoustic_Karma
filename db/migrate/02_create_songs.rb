class CreateSongs < ActiveRecord::Migration[5.1]
    def change 
      create_table :songs do |t|
        t.string :name
        t.string :release_date
        t.integer :user_id
        t.integer :album_id
      end
    end
end