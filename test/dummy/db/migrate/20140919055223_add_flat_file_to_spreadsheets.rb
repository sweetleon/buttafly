class AddFlatFileToSpreadsheets < ActiveRecord::Migration
  def change
    add_column :buttafly_spreadsheets, :flat_file, :string
  end
end
