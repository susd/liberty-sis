class PolymorphicAddresses < ActiveRecord::Migration
  def change
    change_table(:addresses) do |t|
      t.references :addressable, polymorphic: true, index: true
    end
  end
end
