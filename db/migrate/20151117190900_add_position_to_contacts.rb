class AddPositionToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :position, :integer
  end
end
