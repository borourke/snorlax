class AddProjectIdToUnitData < ActiveRecord::Migration
  def change
    add_column :unit_data, :project_id, :integer
  end
end
