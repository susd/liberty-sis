class FixFormOptionsIndex < ActiveRecord::Migration
  def change
    remove_index :report_card_form_options, :options
    add_index :report_card_form_options, :options, using: :gin
  end
end
