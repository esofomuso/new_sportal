class AddSelectedToAppealCourses < ActiveRecord::Migration
  def change
    add_column :appeal_courses, :selected, :boolean, :default => false
  end
end
