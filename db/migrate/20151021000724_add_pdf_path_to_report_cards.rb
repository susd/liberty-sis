class AddPdfPathToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :pdf_path, :text
  end
end
