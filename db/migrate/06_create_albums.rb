class CreateAlbums < ActiveRecord::Migration[5.1]
    def change 
      create_table :albums do |t|
        t.string :name
        t.string :release_date
        t.integer :user_id
      end
    end
end