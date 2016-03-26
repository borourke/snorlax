class CreateTransformation < ActiveRecord::Migration
  def change
    create_table :transformations do |t|
      t.integer :starting_job_id
      t.integer :ending_job_id
      t.text :code
      t.string :type
    end
  end
end
