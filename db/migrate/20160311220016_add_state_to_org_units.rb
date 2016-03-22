class AddStateToOrgUnits < ActiveRecord::Migration
  def change
    add_column :gapps_org_units, :state, :integer, default: 0, null: false
  end
end
