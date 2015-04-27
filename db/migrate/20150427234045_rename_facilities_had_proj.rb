class RenameFacilitiesHadProj < ActiveRecord::Migration
  def change
  	rename_column :facilities, :had_proj, :has_projector
  end
end
