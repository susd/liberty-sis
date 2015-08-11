class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.belongs_to :site, index: true, foreign_key: true
      t.jsonb :import_details

      t.timestamps null: false
    end
  end
end
