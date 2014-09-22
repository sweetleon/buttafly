class CreateDummyParents < ActiveRecord::Migration
  def change
    create_table :dummy_parents do |t|
      t.string :mother_name

      t.timestamps
    end
  end
end
