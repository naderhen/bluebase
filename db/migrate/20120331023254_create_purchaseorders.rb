class CreatePurchaseorders < ActiveRecord::Migration
  def change
    create_table :purchaseorders do |t|
      t.integer :po_number
      t.date :po_date
      t.integer :shipper_id
      t.boolean :active
      t.string :locale
      t.string :origin
      t.string :airline
      t.string :customs_broker
      t.date :date_of_arrival
      t.integer :warehouse_id
      t.integer :airport_id

      t.timestamps
    end
  end
end
