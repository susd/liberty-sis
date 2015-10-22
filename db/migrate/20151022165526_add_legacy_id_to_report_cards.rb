class AddLegacyIdToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :legacy_id, :integer, null: true
    add_index :report_cards, :legacy_id
  end
end
