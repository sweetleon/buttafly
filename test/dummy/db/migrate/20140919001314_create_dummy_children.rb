class CreateDummyChildren < ActiveRecord::Migration
  def change
    create_table :dummy_children do |t|
      t.string :child_name
      t.integer :dummy_parent_id

      t.timestamps
    end
  end
end
