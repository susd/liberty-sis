class CreateReportCardForms < ActiveRecord::Migration
  def change
    create_table :report_card_forms do |t|
      t.string :name
      t.string :renderer

      t.timestamps null: false
    end
  end
end
