class ActivityObserver < ActiveRecord::Observer
	observe :purchaseorder

	def after_update(model)
	end
end