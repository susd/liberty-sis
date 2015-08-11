class RenameLegacyGradeId < ActiveRecord::Migration
  def change
    rename_column :grades, :gid, :legacy_id
  end
end
