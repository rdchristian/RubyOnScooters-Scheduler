class AddMemoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :memo, :text
  end
end
