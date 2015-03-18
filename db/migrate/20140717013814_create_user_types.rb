class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table(:user_types) do |t|
      t.string :name,              :null => false
      t.timestamps
    end

    add_index :user_types, :name,                :unique => true
    
  end
end
