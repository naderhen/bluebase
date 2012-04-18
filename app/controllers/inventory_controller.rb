class InventoryController < ApplicationController
	before_filter :authenticate_user!
	def home
		@purchaseorders = Purchaseorder.all
		@items = @purchaseorders.last.items
		@shippers = Shipper.all
		@customers = Customer.all
		@warehouses = Warehouse.all
		@user = current_user
		@users = User.all
	end
end
