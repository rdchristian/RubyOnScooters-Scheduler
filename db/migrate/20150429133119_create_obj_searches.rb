class CreateObjSearches < ActiveRecord::Migration
  def change
    create_table :obj_searches do |t|
      t.date :search_date

      t.timestamps null: false
    end
  end
end
