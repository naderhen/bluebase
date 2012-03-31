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
end