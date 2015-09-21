class AddStateToStudents < ActiveRecord::Migration
  def change
    add_column :students, :state, :integer, default: 0, null: false
    add_index :students, :state
  end
end
