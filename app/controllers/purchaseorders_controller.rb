class PurchaseordersController < ApplicationController
	respond_to :json

	def index
		if current_user.role == "Warehouse Grader"
			@purchaseorders = Purchaseorder.where(warehouse_id: current_user.warehouse_id)
		else
			@purchaseorders = Purchaseorder.all
		end
		respond_with @purchaseorders
	end

	def create
		respond_with Purchaseorder.create(params[:purchaseorder])
	end

	def update
		@purchaseorder = Purchaseorder.find(params[:id])
		if @purchaseorder.update_attributes!(params[:purchaseorder])
			respond_with @purchaseorder.update_attributes!(params[:purchaseorder])
			@activity = Activity.create! user_id: current_user.id, target_type: 'Purchaseorder', target_id: @purchaseorder.id, target_action: 'update'	
		end
	end

	def show
		@purchaseorder = Purchaseorder.find(params[:id])
	end
end
