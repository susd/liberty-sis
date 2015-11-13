class AddStreet2ToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :street2, :text
  end
end
