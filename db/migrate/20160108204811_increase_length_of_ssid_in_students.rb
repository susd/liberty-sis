class IncreaseLengthOfSsidInStudents < ActiveRecord::Migration
  def change
    remove_index :students, :ssid
    change_column :students, :ssid, :integer, limit: 8
    add_index :students, :ssid
  end
end
