class CreatePosts < ActiveRecord::Migration[5.1]
    def change 
      create_table :posts do |t|
        t.string :content
        t.integer :user_id
        # t.datetime :date_posted
      end
    end
end