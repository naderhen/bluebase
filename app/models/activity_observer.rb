class ActivityObserver < ActiveRecord::Observer
	observe :purchaseorder

	def after_update(model)
		binding.pry
	end
end