class ChangeAlbumReleaseDateToDatetime < ActiveRecord::Migration[5.1]
    def change
        change_column :albums, :release_date, :datetime
    end
end