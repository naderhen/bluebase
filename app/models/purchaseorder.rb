class Purchaseorder < ActiveRecord::Base
	belongs_to :shipper
	belongs_to :warehouse
	belongs_to :airport
	has_many :items

  has_attached_file :document
  acts_as_taggable
  acts_as_commentable

	def locale
    	if self.warehouse
      		return self.warehouse.short_name
    	else
      		return 'TBD'
    	end
  	end
end
