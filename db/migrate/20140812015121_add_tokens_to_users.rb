class AddTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student_notes, :text
    add_column :users, :registrar_notes, :text
    add_column :users, :auth_token, :string
  end
end
