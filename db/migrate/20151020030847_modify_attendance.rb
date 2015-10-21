class ModifyAttendance < ActiveRecord::Migration
  def change
    remove_column :attendances, :code
    change_column :attendances, :kind, :integer, default: 0, null: false
    change_column :attendances, :day, :integer, default: 0, null: false
  end
end
