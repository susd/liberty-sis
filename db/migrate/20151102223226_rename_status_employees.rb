class RenameStatusEmployees < ActiveRecord::Migration
  def change
    if column_exists?(:employees, :status)
      rename_column :employees, :status, :state
    end
  end
end
