class CreateDummyTribes < ActiveRecord::Migration
  def change
    create_table :dummy_tribes do |t|
      t.string :name

      t.timestamps
    end
  end
end
