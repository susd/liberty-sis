class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text :name
      t.text :principal
      t.text :abbr
      t.integer :code

      t.timestamps null: false
    end
  end
end
