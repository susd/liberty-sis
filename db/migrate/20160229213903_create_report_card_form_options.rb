class CreateReportCardFormOptions < ActiveRecord::Migration
  def change
    create_table :report_card_form_options do |t|
      t.string  :field_name
      t.integer :field_type, null: false, default: 0
      t.jsonb   :options, null: false, default: '{}', index: true
      t.belongs_to :report_card_form, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
