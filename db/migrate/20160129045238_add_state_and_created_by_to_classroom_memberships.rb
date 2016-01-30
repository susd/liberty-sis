class AddStateAndCreatedByToClassroomMemberships < ActiveRecord::Migration
  def change
    add_column :classroom_memberships, :state, :integer, default: 0, null: false
    add_column :classroom_memberships, :created_by, :integer, default: 0, null: false
  end
end
