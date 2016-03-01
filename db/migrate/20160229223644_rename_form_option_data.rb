class RenameFormOptionData < ActiveRecord::Migration
  def change
    rename_column :report_card_form_options, :options, :data
  end
end
