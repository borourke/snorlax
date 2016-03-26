class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :alias
      t.string :akon_id
      t.text :formatted_webhook_uri
    end
  end
end
