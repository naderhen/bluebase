collection @purchaseorders
attributes :id, :po_number, :po_date, :shipper_id, :locale, :origin

child :shipper do
	attributes :id, :name
end