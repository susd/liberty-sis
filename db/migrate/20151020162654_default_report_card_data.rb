class DefaultReportCardData < ActiveRecord::Migration
  def change
    change_column :report_cards, :data, :jsonb, null: false, default: '{}'
  end
end
