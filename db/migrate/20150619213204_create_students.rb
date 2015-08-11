class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|

      # General
      t.string  :first_name,    index: true
      t.string  :last_name,     index: true
      t.string  :middle_name
      t.string  :sex
      t.datetime :birthdate,    index: true

      # School, etc.
      t.belongs_to :site,   index: true, foreign_key: true
      t.belongs_to :grade,  index: true, foreign_key: true
      t.integer :homeroom_id,   index: true

      # Home, background, language, etc.
      t.integer :home_lang_id,  index: true
      t.belongs_to :ethnicity
      t.belongs_to :race
      t.belongs_to :family

      # Status enums
      t.integer :enrollment_status, default: 0, null: false
      t.integer :flag, default: 0, null: false

      #legacy
      t.integer :legacy_id
      t.index   :legacy_id, unique: true

      t.timestamps null: false
    end
  end
end
