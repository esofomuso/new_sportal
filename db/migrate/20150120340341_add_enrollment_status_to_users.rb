class AddEnrollmentStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_enrollment_status, :string, :default => 'Pending'
    add_column :users, :next_enrollment_status, :string, :default => 'Pending'
    add_column :courses, :is_elective, :boolean, :default => false
  end
end
