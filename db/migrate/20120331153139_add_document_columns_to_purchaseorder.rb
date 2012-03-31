class AddDocumentColumnsToPurchaseorder < ActiveRecord::Migration
  def change
  	change_table :purchaseorders do |t|
  		t.has_attached_file :document
  	end
  end
end
