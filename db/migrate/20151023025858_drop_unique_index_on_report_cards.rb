class DropUniqueIndexOnReportCards < ActiveRecord::Migration
  def change
    remove_index :report_cards, [:student_id, :year]
  end
end
