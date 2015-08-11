class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|

      # General
      t.string  :type,        index: true
      t.string  :first_name
      t.string  :last_name,   index: true
      t.string  :sex
      t.string  :email,       index: true
      t.date    :birthdate,   index: true

      # Employment
      t.date    :hired_on
      t.integer :years_edu,       default: 0, null: false
      t.integer :years_district,  default: 0, null: false
      t.string  :title
      t.integer :status, default: 0, null: false

      t.integer :legacy_id,   index: true

      t.belongs_to :site, index: true, foreign_key: true
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
