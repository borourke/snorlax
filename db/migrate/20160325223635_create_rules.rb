class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :starting_job_id
      t.integer :ending_job_id
      t.text :field
      t.text :value
      t.integer :transformation_id
    end
  end
end
