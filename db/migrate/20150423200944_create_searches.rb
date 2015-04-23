class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.date :start_date
      t.timestamp :start
      t.timestamp :ending

      t.timestamps null: false
    end
  end
end
