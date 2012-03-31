class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :short_name

      t.timestamps
    end
  end
end
