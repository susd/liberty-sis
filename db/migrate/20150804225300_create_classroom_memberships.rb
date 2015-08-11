class CreateClassroomMemberships < ActiveRecord::Migration
  def change
    create_table :classroom_memberships do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :classroom, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
