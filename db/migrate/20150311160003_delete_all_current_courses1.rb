class DeleteAllCurrentCourses1 < ActiveRecord::Migration
  def change
    CurrentCourse.delete_all
  end
end
