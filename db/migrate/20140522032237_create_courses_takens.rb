class CreateCoursesTakens < ActiveRecord::Migration
  def change
    create_table :courses_takens do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
