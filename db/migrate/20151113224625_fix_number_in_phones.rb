class FixNumberInPhones < ActiveRecord::Migration
  def change
    remove_index :phones, :number
    remove_column :phones, :number, :integer

    change_table :phones do |t|
      t.text :normal
    end
  end
end
