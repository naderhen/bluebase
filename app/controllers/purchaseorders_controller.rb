require 'csv'
require 'open-uri'
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

	def export
		@purchaseorder = Purchaseorder.find(params[:id])
		@items = @purchaseorder.items
		csv_file = CSV.open("#{Rails.root}/public/system/exports/#{@purchaseorder.po_number}.csv", "wb") do |csv|
			csv << ["BOX", "ITEM", "KIND", "PO Grade", "WEIGHT", "CODE", "GO Grade", "GO Freshness", "GO Texture", "GO Grade 2", "COST", "Grade Notes", "Line Detail"]
			@items.each do |item|
				csv << [item.box_number, item.item_number, item.species, '', item.weight, item.code, item.core_grade, item.freshness_grade, item.texture_grade, item.shipper_grade, item.cost, item.grade_notes, item.description]
			end
		end
		respond_with @purchaseorder
	end
end
