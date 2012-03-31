class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :purchaseorder_id
      t.integer :box_number
      t.integer :item_number
      t.float :weight
      t.string :code
      t.float :cost
      t.string :grade_notes
      t.string :description
      t.string :species
      t.string :subspecies
      t.string :shipper_grade
      t.string :core_grade
      t.string :freshness_grade
      t.string :texture_grade
      t.string :tail_grade

      t.timestamps
    end
  end
end
