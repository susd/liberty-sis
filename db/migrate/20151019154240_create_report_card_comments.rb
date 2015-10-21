class CreateReportCardComments < ActiveRecord::Migration
  def change
    create_table :report_card_comments do |t|
      t.text :english
      t.text :spanish
      t.belongs_to :report_card_comment_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
