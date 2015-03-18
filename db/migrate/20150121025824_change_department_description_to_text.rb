class ChangeDepartmentDescriptionToText < ActiveRecord::Migration
  def change
    change_column :departments, :description, :text
  end
end
