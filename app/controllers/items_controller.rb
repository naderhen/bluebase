class ItemsController < ApplicationController
	respond_to :json

	def index
		@items = Item.all
		respond_with @items
	end

	def update
		@item = Item.find(params[:id])
		@params = params
		if @item.update_attributes! params[:item]
			@item.tag_list = params[:tag_list]
			if @item.save!
				respond_with @item
			end
		end
	end
end
