class DropObjSearches < ActiveRecord::Migration
  def change
  	drop_table :obj_searches 
  end
end
