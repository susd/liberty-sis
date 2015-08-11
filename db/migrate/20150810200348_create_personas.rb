class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.string :handler
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
