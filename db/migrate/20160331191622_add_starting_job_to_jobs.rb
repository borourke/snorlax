class AddStartingJobToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :starting_job, :boolean
  end
end
