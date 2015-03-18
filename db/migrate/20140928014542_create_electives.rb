class CreateElectives < ActiveRecord::Migration
  def change
    create_table :electives do |t|
      t.string :name
      t.text :description
      t.string	:code
      t.integer :department_id
      t.integer :grade_id

      t.timestamps
    end
    add_reference :courses, :main_course, index: true
    create_table :current_electives do |t|
      t.integer :elective_id
      t.integer :user_id

      t.timestamps
    end
  end
end
