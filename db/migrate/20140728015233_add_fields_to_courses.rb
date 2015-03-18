class AddFieldsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :grade_id, :integer
  end
end
