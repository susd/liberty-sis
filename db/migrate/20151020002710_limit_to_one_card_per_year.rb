class LimitToOneCardPerYear < ActiveRecord::Migration
  def change
    add_index :report_cards, [:student_id, :year], unique: true
  end
end
