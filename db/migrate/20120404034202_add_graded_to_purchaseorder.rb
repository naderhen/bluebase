class AddGradedToPurchaseorder < ActiveRecord::Migration
  def change
  	add_column :purchaseorders, :graded, :boolean
  	add_column :items, :graded, :boolean
  end
end
