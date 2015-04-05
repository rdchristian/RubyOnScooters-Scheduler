class CreateEventsFacilities < ActiveRecord::Migration
  def self.up
    create_table :events_facilities, :id => false do |t|
        t.references :event
        t.references :facility
    end
    add_index :events_facilities, [:event_id, :facility_id]
    add_index :events_facilities, :facility_id
  end

  def self.down
    drop_table :events_facilities
  end
end
