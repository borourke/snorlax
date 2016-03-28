class AddProjectIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :project_id, :integer
  end
end
