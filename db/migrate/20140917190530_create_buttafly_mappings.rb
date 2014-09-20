class CreateButtaflyMappings < ActiveRecord::Migration
  def change
    create_table :buttafly_mappings do |t|
      t.integer :legend_id
      t.integer :originable_id
      t.string :originable_type
      t.integer :targetable_id
      t.string :targetable_type

      t.timestamps
    end
  end
end
