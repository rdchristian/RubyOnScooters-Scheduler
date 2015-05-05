class AddRecurrenceToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :recurrence, :text
  end
end
