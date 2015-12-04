class RenamePhoneColumn < ActiveRecord::Migration
  def change
    rename_column :phones, :normal, :number
  end
end
