class CreateGappsOrgUnits < ActiveRecord::Migration
  def change
    create_table :gapps_org_units do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.string :gapps_id
      t.string :gapps_path
      t.string :gapps_parent_id
      t.string :gapps_parent_path
      t.datetime :synced_at

      t.timestamps null: false
    end
  end
end
