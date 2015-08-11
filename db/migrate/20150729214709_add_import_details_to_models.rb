class AddImportDetailsToModels < ActiveRecord::Migration
  def change
    add_column :students, :import_details, :jsonb, null: false, default: '{}'
    add_column :employees, :import_details, :jsonb, null: false, default: '{}'
    change_column :classrooms, :import_details, :jsonb, null: false, default: '{}'
  end
end
