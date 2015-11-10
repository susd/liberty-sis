class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :label, null: false, default: 'mailing', index: true
      t.text :street, index: true
      t.text :city, index: true
      t.text :state, null: false, default: 'CA'
      t.text :country, null: false, default: 'USA'
      t.integer :zip, null: false, default: 91355

      t.timestamps null: false
    end
  end
end
