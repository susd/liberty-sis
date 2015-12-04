class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :contactable, polymorphic: true, index: true
      t.string :label
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :note
      t.jsonb :import_details

      t.timestamps null: false
    end
  end
end
