class ShippersController < ApplicationController
	respond_to :json

	def index
		@shippers = Shipper.all
		respond_with @shippers
	end
end
