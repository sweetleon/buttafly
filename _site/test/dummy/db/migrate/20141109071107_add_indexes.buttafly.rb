# This migration comes from buttafly (originally 20140917190801)
class AddIndexes < ActiveRecord::Migration
  def change

    add_index :buttafly_mappings, :legend_id
    add_index :buttafly_mappings, [:originable_id, :originable_type]

    add_index :buttafly_spreadsheets, :user_id
    add_index :buttafly_spreadsheets, :name
    add_index :buttafly_spreadsheets, :imported_at
    add_index :buttafly_spreadsheets, :processed_at
    add_index :buttafly_spreadsheets, :aasm_state
  end
end
