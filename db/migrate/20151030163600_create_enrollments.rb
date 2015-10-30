class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :site, index: true, foreign_key: true
      t.belongs_to :classroom, index: true, foreign_key: true
      t.belongs_to :grade, index: true, foreign_key: true
      t.integer :year, default: 2015
      t.integer :state, null: false, default: 0
      t.date :starts_on
      t.date :ends_on
      t.jsonb :import_details, null: false, default: '{}'

      t.timestamps null: false
    end
  end
end
