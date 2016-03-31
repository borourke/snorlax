class AddProjectIdToRules < ActiveRecord::Migration
  def change
    add_column :rules, :project_id, :integer
  end
end
