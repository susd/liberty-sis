class AddIndexToRoles < ActiveRecord::Migration
  def change
    add_index :roles, :permissions, using: :gin
  end
end
