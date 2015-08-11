class CreateGradingPeriods < ActiveRecord::Migration
  def change
    create_table :grading_periods do |t|
      t.date :start
      t.date :finish
      t.integer :position
      t.integer :year

      t.timestamps null: false
    end
  end
end
