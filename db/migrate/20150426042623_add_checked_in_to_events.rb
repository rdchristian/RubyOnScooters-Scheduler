class AddCheckedInToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :checked_in, :boolean, default: false
  end
end
