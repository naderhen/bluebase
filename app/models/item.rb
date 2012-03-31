class Item < ActiveRecord::Base
	belongs_to :purchaseorder
	has_paper_trail
	acts_as_taggable

	after_create :parse_code

	def parse_code
		item_code = ItemCode.where(code: code).first
	    self.species = item_code.species
	    self.subspecies = item_code.subspecies
	    save!
	end

	def po_number
    	self.purchaseorder.po_number
  	end
end
