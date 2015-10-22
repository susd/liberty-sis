class CreateSyncEvents < ActiveRecord::Migration
  def change
    create_table :sync_events do |t|
      t.string :label, index: true
      t.integer :state, null: false, default: 0, index: true
      t.integer :action, null: false, default: 0, index: true
      t.references :syncable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
