class CreateFacilities < ActiveRecord::Migration
  def up
    create_table 'facilities' do |t|
      t.string 'name'
      t.text 'description'

      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
 
  def down
    drop_table 'facilities' # deletes the whole table and all its data!
  end
end