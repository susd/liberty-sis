class AddImportDetailsToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :import_details, :jsonb, null: false, default: '{}'
  end
end
