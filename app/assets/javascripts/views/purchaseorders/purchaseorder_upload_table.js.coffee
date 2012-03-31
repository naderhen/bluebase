class Bluebase.Views.PurchaseorderUploadTable extends Backbone.View

	template: JST['purchaseorders/upload_table']

	render: ->
		console.log(@collection)
		this