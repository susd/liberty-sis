class AddTakenOnToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :taken_on, :date
    add_index :assessments, :taken_on
  end
end
