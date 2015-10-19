class CreateCommentsReportCards < ActiveRecord::Migration
  def change
    create_table(:comments_report_cards, id: false) do |t|
      t.references :report_card_comment
      t.references :report_card
    end
    add_index :comments_report_cards, [:report_card_comment_id, :report_card_id], unique: true, name: 'index_comments_report_cards'
  end
end
