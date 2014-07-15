class AddCurrentStudentToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :current_student, :boolean
  end
end
