class CreateClassroomLeaderships < ActiveRecord::Migration
  def change
    create_table :classroom_leaderships do |t|
      t.belongs_to :employee, index: true, foreign_key: true
      t.belongs_to :classroom, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
