class ChangeCurrentFacultyToFaculty < ActiveRecord::Migration
  def change
    change_table :artists do |t|
      t.rename :current_faculty, :faculty
    end
  end
end
