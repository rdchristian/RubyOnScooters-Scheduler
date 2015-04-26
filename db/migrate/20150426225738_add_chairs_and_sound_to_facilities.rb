class AddChairsAndSoundToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :has_chairs, :boolean
    add_column :facilities, :has_sound, :boolean
  end
end
