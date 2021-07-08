class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :pickup_address, default: ''
      t.float :pick_lat
      t.float :pick_lng
      t.string :drop_address, default: ''
      t.float :drop_lat
      t.float :drop_lng
      t.boolean :is_claimed, default: false
      t.boolean :is_executed, default: false
      t.integer :gogetter_id
      t.integer :user_id

      t.timestamps
    end
  end
end
