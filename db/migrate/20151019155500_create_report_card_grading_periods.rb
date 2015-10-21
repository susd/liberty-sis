class CreateReportCardGradingPeriods < ActiveRecord::Migration
  def change
    create_table :report_card_grading_periods do |t|
      t.date :starts_on
      t.date :ends_on
      t.integer :position, default: 0, null: false
      t.integer :year, default: 2015, null: false

      t.timestamps null: false
    end
  end
end
