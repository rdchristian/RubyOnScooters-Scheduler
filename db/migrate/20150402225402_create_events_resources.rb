class CreateEventsResources < ActiveRecord::Migration
  def self.up
    create_table :events_resources, :id => false do |t|
        t.references :event
        t.references :resource
    end
    add_index :events_resources, [:event_id, :resource_id]
    add_index :events_resources, :resource_id
  end

  def self.down
    drop_table :events_resources
  end
end
