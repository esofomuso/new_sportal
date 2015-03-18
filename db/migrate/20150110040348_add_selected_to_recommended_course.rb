class AddSelectedToRecommendedCourse < ActiveRecord::Migration
  def change
    add_column :recommended_courses, :selected, :boolean, :default => false
  end
end
