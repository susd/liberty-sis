class AddOrgUnitToStudentsEmployees < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.belongs_to :gapps_org_unit, foreign_key: true
    end

    change_table :employees do |t|
      t.belongs_to :gapps_org_unit, foreign_key: true
    end
  end
end
