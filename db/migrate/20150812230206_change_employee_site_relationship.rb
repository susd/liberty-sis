class ChangeEmployeeSiteRelationship < ActiveRecord::Migration
  def change
    create_table :employees_sites, id: false do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :site, index: true
    end
  end
end
