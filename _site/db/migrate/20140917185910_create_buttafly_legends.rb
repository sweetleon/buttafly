class CreateButtaflyLegends < ActiveRecord::Migration
  def change
    create_table :buttafly_legends do |t|
      t.integer :cartographer_id
      t.json :data
      t.string :name

      t.timestamps
    end
  end
end
