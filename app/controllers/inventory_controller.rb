class InventoryController < ApplicationController
	before_filter :authenticate_user!
	def home
		@purchaseorders = Purchaseorder.all.to_a
		@items = @purchaseorders.last.items
		@shippers = Shipper.all.to_a
		@warehouses = Warehouse.all.to_a
		@user = current_user
	end
end
