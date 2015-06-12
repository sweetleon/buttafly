class ChangeJsonColumnNames < ActiveRecord::Migration
  def change
    rename_column(:buttafly_mappings, :data, :legend_data)
  end
end
