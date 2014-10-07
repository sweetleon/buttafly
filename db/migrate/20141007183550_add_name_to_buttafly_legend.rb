class AddNameToButtaflyLegend < ActiveRecord::Migration
  def change
    add_column :buttafly_legends, :name, :string
  end
end
