class Warehouse < ActiveRecord::Base
	has_many :purchaseorders
end
