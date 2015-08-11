class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.text :name
      t.jsonb :permissions, default: {}, null: false

      t.timestamps null: false
    end
  end
end
