collection @purchaseorders
attributes :id, :po_number, :po_date, :shipper_id, :locale, :origin, :graded

child :shipper do
	attributes :id, :name
end