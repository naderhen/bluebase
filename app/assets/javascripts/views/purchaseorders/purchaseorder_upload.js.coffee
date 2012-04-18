class Bluebase.Views.PurchaseorderUpload extends Backbone.View

	template: JST['purchaseorders/upload']

	render: ->
		self = @
		purchaseorder = @model
		$(@el).html(@template(model: @model))

		@$("#upload-attachment-form").submit ->
			$.ajax('/api/attachments',
				files: $(":file", this)
				data: $(":text", this).serializeArray()
				iframe: true
				type: "POST"
				processData: false
				dataType: "json"
				success: (data) ->
					items = $.parseJSON(data.items_object)
					uploading_collection = new Bluebase.Collections.Items
					header_row = items.shift()

					attribute_map = {
						"BOX": "box_number"
						"ITEM": "item_number"
						"KIND": "kind"
						"PO GRADE": "po_grade"
						"WEIGHT": "weight"
						"CODE": "code"
						"GO GRADE": "core_grade"
						"GO FRESHNESS": "freshness_grade"
						"GO TEXTURE": "texture_grade"
						"COST": "cost"
						"GRADE NOTES": "grade_notes"
						"LINE DETAIL": "line_detail"
					}

					$.each items, (i, item) ->
						jsonObj = []
						jsonObj['purchaseorder_id'] = purchaseorder.get('id')
						$.each item, (i, v) ->
							jsonObj[attribute_map[header_row[i]]] = v

						model = new Bluebase.Models.Item
						model.set(jsonObj)
						if model.get('box_number') != "DONE"
							uploading_collection.add(model)
					upload_table_view = new Bluebase.Views.PurchaseorderUploadTable(collection: uploading_collection)
					$(self.el).html(upload_table_view.render().el)
				)
			return false
		this