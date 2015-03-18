class CreateStudentDepartmentAppeals < ActiveRecord::Migration
  def change
    create_table :student_department_appeals do |t|
      t.integer :user_id
      t.integer :department_id
      t.string :comment

      t.timestamps
    end
  end
end
