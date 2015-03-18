class DeleteAllCurrentCourses < ActiveRecord::Migration
  def change
    CurrentCourse.delete_all
  end
end
