class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.text :name
      t.text :calpads_name
      t.integer :calpads_code
      t.integer :aeries_code

      t.timestamps null: false
    end
  end
end
