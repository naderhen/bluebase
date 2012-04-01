class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :target_type
      t.integer :target_id
      t.string :target_action

      t.timestamps
    end
  end
end
