class CustomersController < ApplicationController
	respond_to :json

	def index
		@customers = Customer.all
		respond_with @customers
	end

end
