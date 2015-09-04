class AddPrimarySiteToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :primary_site_id, :integer
  end
end
