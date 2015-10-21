class AddPeriodToReportCards < ActiveRecord::Migration
  def change
    change_table(:report_cards) do |t|
      t.belongs_to :report_card_grading_period, foreign_key: true
    end
  end
end
