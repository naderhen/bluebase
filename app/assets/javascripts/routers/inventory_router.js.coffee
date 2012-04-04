class Bluebase.Routers.Inventory extends Backbone.Router
	routes:
		'': 'index'

	initialize: ->
		@purchaseorders = new Bluebase.Collections.Purchaseorders()
		@purchaseorders.fetch()
		PUBNUB.subscribe({
			channel: 'activities_new',
			callback: (message) ->
				console.log (message)
			})

	index: ->
		purchase_orders_view = new Bluebase.Views.PurchaseordersIndex({collection: @purchaseorders})
		$('#left').html(purchase_orders_view.render().el)