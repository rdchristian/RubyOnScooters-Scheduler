class AddResourceCountsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :resource_counts, :text
  end
end
