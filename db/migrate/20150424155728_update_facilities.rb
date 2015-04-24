class UpdateFacilities < ActiveRecord::Migration
  def change
  	add_column :facilities, :min_capacity, :integer
    add_column :facilities, :priority, :boolean
    add_column :facilities, :has_tv, :boolean
    add_column :facilities, :has_tables, :boolean
    add_column :facilities, :had_proj, :boolean
  end
end
