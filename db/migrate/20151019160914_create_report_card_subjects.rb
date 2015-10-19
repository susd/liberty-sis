class CreateReportCardSubjects < ActiveRecord::Migration
  def change
    create_table :report_card_subjects do |t|
      t.string :name
      t.string :spanish_name
      t.string :slug
      t.belongs_to :report_card_form, index: true, foreign_key: true
      t.integer :position
      t.boolean :major
      t.boolean :show_score
      t.boolean :show_effort
      t.boolean :show_level
      t.boolean :side_section
      t.boolean :positional_score

      t.timestamps null: false
    end
  end
end
