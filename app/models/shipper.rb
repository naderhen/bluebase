class Shipper < ActiveRecord::Base
	has_many :purchaseorders
end
