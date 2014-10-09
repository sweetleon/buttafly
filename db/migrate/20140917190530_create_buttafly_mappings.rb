class CreateButtaflyMappings < ActiveRecord::Migration
  def change
    create_table :buttafly_mappings do |t|
      t.integer :legend_id
      t.integer :originable_id
      t.string :originable_type
      t.string :targetable_class

      t.timestamps
    end
  end
end
