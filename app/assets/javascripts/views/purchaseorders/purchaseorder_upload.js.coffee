class Bluebase.Views.PurchaseorderUpload extends Backbone.View

	template: JST['purchaseorders/upload']

	render: ->
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
					$.each items, (i, item) ->
						jsonObj = []
						jsonObj['purchaseorder_id'] = purchaseorder.get('id')
						$.each item, (i, v) ->
							jsonObj[header_row[i]] = v

						model = new Bluebase.Models.Item
						model.set(jsonObj)
						uploading_collection.add(model)

					upload_table_view = new Bluebase.Views.PurchaseorderUploadTable(collection: uploading_collection)
					upload_table_view.render()
				)
			return false
		this