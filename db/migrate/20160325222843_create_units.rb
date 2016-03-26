class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :project_id
    end
  end
end
