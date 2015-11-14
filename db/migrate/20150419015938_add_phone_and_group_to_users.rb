class AddPhoneAndGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :bigint
    add_column :users, :home_group, :string
  end
end
