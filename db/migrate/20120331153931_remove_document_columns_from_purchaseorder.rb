class RemoveDocumentColumnsFromPurchaseorder < ActiveRecord::Migration
  def up
  	drop_attached_file :purchaseorders, :document
  end

  def down
  end
end
