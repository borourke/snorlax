class AddOperationToRules < ActiveRecord::Migration
  def change
    add_column :rules, :operation, :string
  end
end
