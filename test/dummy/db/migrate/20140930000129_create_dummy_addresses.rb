class CreateDummyAddresses < ActiveRecord::Migration
  def change
    create_table :dummy_addresses do |t|
      t.string :city

      t.timestamps
    end
  end
end
