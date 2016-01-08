class AddSsiDsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :ssid, :integer
    add_index :students, :ssid
  end
end
