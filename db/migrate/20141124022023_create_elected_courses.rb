class CreateElectedCourses < ActiveRecord::Migration
  def change
    create_table :elected_courses do |t|
      t.integer :elective_id
      t.integer :user_id

      t.timestamps
    end
  end
end
