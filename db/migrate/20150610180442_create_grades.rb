class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.text :name
      t.float :position
      t.text :gid

      t.timestamps null: false
    end
  end
end
