class Bluebase.Routers.Inventory extends Backbone.Router
	routes:
		'': 'index'

	initialize: ->
		@purchaseorders = new Bluebase.Collections.Purchaseorders()
		@purchaseorders.fetch()
		faye.subscribe '/activities/new', (data) ->
			console.log data

	index: ->
		purchase_orders_view = new Bluebase.Views.PurchaseordersIndex({collection: @purchaseorders})
		$('#left').html(purchase_orders_view.render().el)