class AddSelectedToStudentDepartmentAppeals < ActiveRecord::Migration
  def change
    add_column :student_department_appeals, :selected, :boolean, :default => false
  end
end
