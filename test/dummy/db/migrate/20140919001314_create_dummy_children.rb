class CreateDummyChildren < ActiveRecord::Migration
  def change
    create_table :dummy_children do |t|
      t.string :name
      t.integer :dummy_parent_id
      t.integer :dummy_tribe_id
      t.integer :age

      t.timestamps
    end
  end
end
