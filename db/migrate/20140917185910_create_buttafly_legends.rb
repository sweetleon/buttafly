class CreateButtaflyLegends < ActiveRecord::Migration
  def change
    create_table :buttafly_legends do |t|
      t.integer :cartographer_id
      t.json :data

      t.timestamps
    end
  end
end
