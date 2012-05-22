require 'csv'
class AttachmentsController < ApplicationController

	def handle_unverified_request

	end

	def index
		@attachments = Attachment.all
	end

	def create
		@attachment = Attachment.new
		@attachment.purchaseorder_id = params[:purchaseorder_id]
		@purchaseorder = Purchaseorder.find(params[:purchaseorder_id])
		@attachment.type = "Inventory Import"
		@attachment.document = params[:document]

		if @attachment.save
			if params["X-Requested-With"] == "IFrame"
				if @attachment.document_content_type == "text/csv"
					render :json => { :attachment => @attachment, :items_object => CSV.read('public' + "#{@attachment.document.url[/[^?]+/]}").to_json }
				else
					render :json => @attachment
				end
				
			else
				respond_to do |format|
					format.html {
						render :json => @attachment.to_json,
								:content_type => 'text/html',
								:layout => false
					}
					format.json {
						render :json => @attachment
					}
				end
			end
		else
			render :json => [{:error => "custom_failure"}], :status => 304
		end
	end

	def destroy
		@attachment = Attachment.find(params[:id])
		@attachment.destroy
		render :json => true
	end

	def custom_export
		ids = params[:ids]
		ids_array = ids.split(",")
		items = Item.find(ids_array)
		file_name = Time.now.strftime("%Y%m%d%H%M%S")
		csv_file = CSV.open("public/system/custom_exports/#{file_name}.csv", "wb") do |csv|
			csv << ["PO #", "Box", "Item", "Code", "Weight", "Species", "Grade", "Shipper Grade", "Freshness", "Texture", "Tail"]
			items.each do |item|
				csv << [item.po_number, item.box_number, item.item_number, item.code, item.weight, item.species, item.core_grade, item.shipper_grade, item.freshness_grade, item.texture_grade, item.tail_grade]
			end
		end
		render :json => { :url => "system/custom_exports/#{file_name}.csv"}
	end
end