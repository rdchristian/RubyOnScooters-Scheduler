class AddPictureToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :picture, :string
  end
end
