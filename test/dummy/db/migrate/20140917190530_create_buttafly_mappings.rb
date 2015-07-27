class CreateButtaflyMappings < ActiveRecord::Migration
  def change
    create_table :buttafly_mappings do |t|
      t.integer :originable_id
      t.string :originable_type
      t.string :targetable_model
      t.text :legend

      t.timestamps
    end
  end
end
