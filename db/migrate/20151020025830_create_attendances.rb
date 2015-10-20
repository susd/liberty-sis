class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.date :date
      t.integer :day
      t.integer :code
      t.integer :kind

      t.timestamps null: false
    end
  end
end
