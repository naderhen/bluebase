collection @purchaseorders
attributes :id, :po_number, :po_date, :shipper_id, :locale, :origin, :graded, :root_comments

child :shipper do
	attributes :id, :name
end