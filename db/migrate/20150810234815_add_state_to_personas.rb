class AddStateToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :state, :integer, default: 0, null: false
  end
end
