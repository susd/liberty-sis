class RenameCreatedbyInClassroomMemberships < ActiveRecord::Migration
  def change
    rename_column :classroom_memberships, :created_by, :source
  end
end
