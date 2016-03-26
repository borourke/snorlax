class CreateUnitData < ActiveRecord::Migration
  def change
    create_table :unit_data do |t|
      t.text :field
      t.text :value
      t.integer :unit_id
    end
  end
end
