class AddSelectedToCurrentCourse < ActiveRecord::Migration
  def change
    add_column :current_courses, :selected, :boolean, :default => false
  end
end
