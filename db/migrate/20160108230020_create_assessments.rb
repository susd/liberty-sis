class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.string :name
      t.jsonb :data, null: false, default: '{}'

      t.timestamps null: false
    end

    add_index :assessments, :data, using: :gin
  end
end
