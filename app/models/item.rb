class Item < ActiveRecord::Base
	belongs_to :purchaseorder
	has_paper_trail

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

  	def siblings
  		Item.where(purchaseorder_id: self.purchaseorder_id, box_number: self.box_number).to_json
  	end
end
