class AddImportDetailsToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :import_details, :jsonb, null: false, default: '{}'
  end
end
