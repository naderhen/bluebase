class Warehouse < ActiveRecord::Base
	has_many :purchaseorders
	has_many :users
end
