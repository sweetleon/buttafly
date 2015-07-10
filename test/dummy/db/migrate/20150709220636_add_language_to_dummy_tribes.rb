class AddLanguageToDummyTribes < ActiveRecord::Migration
  def change
    add_column :dummy_tribes, :language, :string
  end
end
