class CommentsController < ApplicationController
	respond_to :json

	def create
		if params[:model_type] == "Purchaseorder"
			@purchaseorder = Purchaseorder.find(params[:model_id])
			@comment = Comment.build_from(@purchaseorder, current_user.id, params[:body])
			if @comment.save!
				respond_with @comment
			end
		elsif params[:model_type] == "Item"
			@item = Item.find(params[:model_id])
			@comment = Comment.build_from(@item, current_user.id, params[:body])
			if @comment.save!
				respond_with @comment
			end
		end
	end
end
