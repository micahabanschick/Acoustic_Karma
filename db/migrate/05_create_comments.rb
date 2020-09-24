class CreateComments < ActiveRecord::Migration[5.1]
    def change 
      create_table :comments do |t|
        t.string :reply
        t.integer :user_id
        t.integer :post_id
      end
    end
end