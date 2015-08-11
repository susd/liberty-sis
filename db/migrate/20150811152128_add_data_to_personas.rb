class AddDataToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :service_id, :string
    add_column :personas, :service_data, :jsonb, default: '{}', null: false
  end
end
