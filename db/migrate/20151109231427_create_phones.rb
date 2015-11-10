class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string  :label, index: true
      t.string  :original, index: true
      t.integer :normal,   index: true
      t.references :callable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
