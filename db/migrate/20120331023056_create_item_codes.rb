class CreateItemCodes < ActiveRecord::Migration
  def change
    create_table :item_codes do |t|
      t.string :code
      t.string :species
      t.string :subspecies

      t.timestamps
    end
  end
end
