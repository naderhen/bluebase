object @purchaseorder
attributes :id, :po_number, :po_date, :graded, :root_comments

child :items do
	attributes :id, :po_number, :box_number, :item_number, :weight, :species, :core_grade, :freshness_grade, :texture_grade, :tail_grade, :tag_list, :customer_id, :graded, :root_comments
end

child :shipper do
	attributes :id, :name
end