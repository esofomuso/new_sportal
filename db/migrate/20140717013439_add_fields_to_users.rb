class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_name, :string
    add_column :users, :preferred_name, :string
    add_column :users, :export_id, :string
    add_column :users, :current_grade_id, :integer
    add_column :users, :next_grade_id, :integer
    add_column :users, :user_type_id, :integer
    add_column :users, :active, :boolean, :default => true
    add_column :users, :can_update, :boolean, :default => true
    add_column :departments, :code, :string
    add_column :courses, :code, :string
  end
end
