class ItemsController < ApplicationController
	respond_to :json

	def index
		@items = Item.all
		respond_with @items
	end

	def update
		@item = Item.find(params[:id])
		@params = params
		respond_with @item.update_attributes! params[:item]
		# respond_with @item.update_attributes!(box_number: @params.box_number, item_number: @params.item_number, weight: @params.weight, species: @params.species, core_grade: @params.core_grade, freshness_grade: @params.freshness_grade, texture_grade: @params.texture_grade, tail_grade: @params.tail_grade)
	end
end
