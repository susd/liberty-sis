class AddSyncedAtToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :synced_at, :datetime, null: true
  end
end
