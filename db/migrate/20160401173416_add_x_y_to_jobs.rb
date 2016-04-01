class AddXYToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :x, :integer
    add_column :jobs, :y, :integer
  end
end
