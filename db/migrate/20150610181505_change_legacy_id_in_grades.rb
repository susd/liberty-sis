class ChangeLegacyIdInGrades < ActiveRecord::Migration
  def change
    remove_column :grades, :legacy_id
    add_column :grades, :legacy_id, :integer, default: 0, null: false
  end
end
