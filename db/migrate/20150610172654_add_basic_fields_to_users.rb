class AddBasicFieldsToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.column :first_name, :text
      t.column :last_name, :text
      t.column :image_url, :text
      t.column :provider, :text
      t.column :uid, :text
    end
  end
end
