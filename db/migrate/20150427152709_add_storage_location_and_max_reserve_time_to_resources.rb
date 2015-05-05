class AddStorageLocationAndMaxReserveTimeToResources < ActiveRecord::Migration
  def change
    add_column :resources, :storage_location, :string
    add_column :resources, :max_reserve_time, :time
  end
end
