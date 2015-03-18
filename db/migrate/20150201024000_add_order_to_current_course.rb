class AddOrderToCurrentCourse < ActiveRecord::Migration
  def change
    add_column :current_courses, :order, :integer
  end
end
