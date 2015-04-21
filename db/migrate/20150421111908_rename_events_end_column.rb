class RenameEventsEndColumn < ActiveRecord::Migration
  def change
  	rename_column :events, :end, :ending # SQL freaked out about 'end'
  end
end
