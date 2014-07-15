class ChangeCurrentStudentToStudent < ActiveRecord::Migration
  def change
    change_table :artists do |t|
      t.rename :current_student, :student
    end
  end
end
