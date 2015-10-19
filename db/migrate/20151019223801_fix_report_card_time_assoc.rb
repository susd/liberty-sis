class FixReportCardTimeAssoc < ActiveRecord::Migration
  def change
    remove_column :report_cards, :report_card_grading_period_id
    add_column :report_cards, :year, :integer, default: Time.now.year, null: false
  end
end
