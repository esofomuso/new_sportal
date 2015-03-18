class CreateAppealCourses < ActiveRecord::Migration
  def change
    create_table :appeal_courses do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
