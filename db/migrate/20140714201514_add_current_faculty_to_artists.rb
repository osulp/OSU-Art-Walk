class AddCurrentFacultyToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :current_faculty, :boolean
  end
end
