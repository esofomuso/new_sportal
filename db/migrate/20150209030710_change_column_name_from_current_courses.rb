class ChangeColumnNameFromCurrentCourses < ActiveRecord::Migration
  def change
  	rename_column :current_courses, :order, :select_order
  end
end
