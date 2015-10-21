class CreateReportCards < ActiveRecord::Migration
  def change
    create_table :report_cards do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :report_card_form, index: true, foreign_key: true
      t.jsonb :data

      t.timestamps null: false
    end
  end
end
