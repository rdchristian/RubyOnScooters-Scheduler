class AddStorageLocationAndMaxReserveTimeToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :storage_location, :string
    add_column :facilities, :max_reserve_time, :time
  end
end
