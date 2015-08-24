class AddAgeToDummyChild < ActiveRecord::Migration
  def change
    add_column :dummy_children, :age, :integer
  end
end
