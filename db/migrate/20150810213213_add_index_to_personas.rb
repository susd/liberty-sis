class AddIndexToPersonas < ActiveRecord::Migration
  def change
    add_index :personas, [:handler, :username], unique: true
  end
end
