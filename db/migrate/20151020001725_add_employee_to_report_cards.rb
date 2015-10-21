class AddEmployeeToReportCards < ActiveRecord::Migration
  def change
    add_reference :report_cards, :employee, index: true, foreign_key: true
  end
end
