class ChangeSongReleaseDateToDatetime < ActiveRecord::Migration[5.1]
    def change
        change_column :songs, :release_date, :datetime
    end
end