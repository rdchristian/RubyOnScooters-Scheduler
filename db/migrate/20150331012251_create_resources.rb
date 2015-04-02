class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.integer :numberOf

      t.timestamps null: false
    end
  end
end
