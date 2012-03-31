class Airport < ActiveRecord::Base
	has_many :purchaseorders
end
