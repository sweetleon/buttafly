# This migration comes from buttafly (originally 20140916214009)
class CreateButtaflySpreadsheets < ActiveRecord::Migration
  def change
    create_table :buttafly_spreadsheets do |t|
      t.json :data
      t.string :name
      t.integer :user_id
      t.datetime :imported_at
      t.datetime :processed_at
      t.string :aasm_state
      t.integer :source_row_count
      t.integer :mtime

      t.timestamps
    end
  end
end
