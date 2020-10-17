class AddColumnsToPosts < ActiveRecord::Migration[5.1]
    def change
      add_column :posts, :date_posted, :datetime
    end
  end