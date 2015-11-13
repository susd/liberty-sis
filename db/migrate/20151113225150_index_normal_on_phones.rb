class IndexNormalOnPhones < ActiveRecord::Migration
  def change
    add_index :phones, :normal
  end
end
