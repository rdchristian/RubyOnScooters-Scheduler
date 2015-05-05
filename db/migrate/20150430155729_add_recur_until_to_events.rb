class AddRecurUntilToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recur_until, :datetime
  end
end
