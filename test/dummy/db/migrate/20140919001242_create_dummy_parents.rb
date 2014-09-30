class CreateDummyParents < ActiveRecord::Migration
  def change
    create_table :dummy_parents do |t|
      t.string :name
      t.integer :dummy_grandparent_id
      t.integer :dummy_address_id

      t.timestamps
    end
  end
end
