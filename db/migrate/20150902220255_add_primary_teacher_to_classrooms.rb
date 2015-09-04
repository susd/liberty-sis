class AddPrimaryTeacherToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :primary_teacher_id, :integer
  end
end
