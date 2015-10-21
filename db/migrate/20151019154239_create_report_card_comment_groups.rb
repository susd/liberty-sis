class CreateReportCardCommentGroups < ActiveRecord::Migration
  def change
    create_table :report_card_comment_groups do |t|
      t.string :name
      t.belongs_to :report_card_form, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
