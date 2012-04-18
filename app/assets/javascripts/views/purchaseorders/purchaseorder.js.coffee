class Bluebase.Views.Purchaseorder extends Backbone.View
	template: JST['purchaseorders/purchaseorder']
	tagName: 'tr'

	events: 
		'click .icon-list': 'addItems'
		'click .icon-ok': 'removeItems'
		'click .edit-purchaseorder': 'editPurchaseorder'
		'click .download-csv': 'downloadPurchaseorder'

	initialize: ->
		@model.on('change', @render, this)

	render: ->
		
		if user.get('role') != "Admin"
		  @model.get('shipper').name = "Unavailable"

		$(@el).html(@template(purchaseorder: @model))
		this

	addItems: (event)->
		self = @
		object = $(event.currentTarget)

		po = new Bluebase.Models.Purchaseorder(@model)
		$('#center, #right').fadeOut()
		object.removeClass('icon-list').addClass('icon-refresh')
		po.fetch({
			success: ->
				new_items = po.get('items')
				items_collection.add(new_items)
				items_view = new Bluebase.Views.ItemsIndex({purchaseorder: po, collection: items_collection})
				$('#center').html(items_view.render().el).fadeIn()

				object.removeClass('icon-refresh').addClass('icon-ok icon-darkblue')
			})

	removeItems: (event) ->
		@
		object = $(event.currentTarget)
		po = new Bluebase.Models.Purchaseorder(@model)
		po_number = po.get('po_number')

		to_be_removed = items_collection.filter((item) ->
			item.get('po_number') == po_number
		)

		items_collection.remove(to_be_removed)
		object.removeClass('icon-ok').addClass('icon-refresh')
		$('#center').fadeOut('fast', ->
			items_view = new Bluebase.Views.ItemsIndex({purchaseorder: po, collection: items_collection})
			$('#center').html(items_view.render().el).fadeIn()
			object.removeClass('icon-refresh icon-darkblue').addClass('icon-list')
		)

	editPurchaseorder: (event) ->
		edit_view = new Bluebase.Views.PurchaseorderEdit(model: @model)
		edit_view.render()
		event.preventDefault()

	downloadPurchaseorder: (event) ->
		model = @model
		$.ajax "api/purchaseorders/#{model.get('id')}/export",
			success: (data) ->
				window.location.href = "system/exports/#{model.get('id')}.csv"