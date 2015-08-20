class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.jsonb :data, default: '{}', null: false

      t.timestamps null: false
    end

    add_index :settings, :name, unique: true
    add_index :settings, :data, using: :gin
  end
end
