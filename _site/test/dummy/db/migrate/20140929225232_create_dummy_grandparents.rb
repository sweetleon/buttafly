class CreateDummyGrandparents < ActiveRecord::Migration
  def change
    create_table :dummy_grandparents do |t|
      t.string :name
      t.integer :dummy_tribe_id

      t.timestamps
    end
  end
end
