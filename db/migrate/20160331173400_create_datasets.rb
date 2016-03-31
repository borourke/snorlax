class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :file_path
    end
  end
end
