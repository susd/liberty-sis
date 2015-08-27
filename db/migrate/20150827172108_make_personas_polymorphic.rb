class MakePersonasPolymorphic < ActiveRecord::Migration
  def up
    add_column :personas, :personable_id, :integer
    add_column :personas, :personable_type, :string, default: 'Student'

    add_index :personas, [:personable_id, :personable_type]

    execute <<-SQL
      UPDATE personas SET personable_id = student_id, personable_type = 'Student'
    SQL
  end

  def down
    remove_index :personas, [:personable_id, :personable_type]
    remove_column :personas, :personable_id
    remove_column :personas, :personable_type
  end
end
