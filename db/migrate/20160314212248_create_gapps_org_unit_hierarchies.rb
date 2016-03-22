class CreateGappsOrgUnitHierarchies < ActiveRecord::Migration
  def change
    create_table :gapps_org_unit_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :gapps_org_unit_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "org_unit_anc_desc_idx"

    add_index :gapps_org_unit_hierarchies, [:descendant_id],
      name: "org_unit_desc_idx"
  end
end
