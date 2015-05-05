class AddUserLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_level, :integer, default: 0
  end
end
