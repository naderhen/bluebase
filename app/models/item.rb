class Item < ActiveRecord::Base
	belongs_to :purchaseorder
	belongs_to :customer
	has_paper_trail
	acts_as_taggable
  	acts_as_commentable
  	
	after_create :parse_code

	def age
		today = Date.today
		date = self.purchaseorder.po_date
		string = (today - date).to_i.to_s
		return string
	end

	def parse_code
		item_code = ItemCode.where(code: code).first
	    self.species = item_code.species
	    self.subspecies = item_code.subspecies
	    save!
	end

	def po_number
    	self.purchaseorder.po_number
  	end

  	def changesets
  		changesets = []
		self.versions.each do |version|
			if !version.changeset.empty?
				changeset = version.changeset
				changeset.merge!({created_at: version.created_at, created_by: version.whodunnit})
				changesets.push(changeset)
			end
		end
		return changesets.to_json
  	end
end
