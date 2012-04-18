class Bluebase.Views.Item extends Backbone.View
	template: JST['items/item']
	tagName: 'tr'

	events: 
		'click .unselected': 'addToSelection'
		'addToSelection': 'addToSelection'
		'click .selected': 'removeFromSelection'
		'click .icon-search': 'loadFunctions'
		'loadFunctions': 'loadFunctions'

	initialize: ->
		@model.on('change', @render, this)
		@model.on('sync', @savedItem, this)
		@model.on('pubnub:update', @pubnubUpdate, this)

	render: ->
		purchaseorder = @.options.purchaseorder
		$(@el).html(@template({item: @model, purchaseorder: purchaseorder}))
		Backbone.ModelBinding.bind(this)
		this

	pubnubUpdate: (data) ->
		@model.set(data.model)
		comment = $(@el).find('.icon-comment')
		comment.attr({
			rel: "tooltip"
			title: "Edited by: " + data.user.name
			}).tooltip().fadeIn()
		sticky_text = "#{data.user.name} updated PO# #{@model.get('po_number')} #{@model.get('box_number')} - #{@model.get('item_number')}"
		$.sticky(sticky_text)
		$(@el).stop(true, true).effect("highlight", {}, 4000)

	savedItem: ->
		$(@el).find('.icon-ok').fadeIn();
		console.log('savedItem')
		PUBNUB.publish({
                channel : "items_update",
                message : {"model": @model, "user": user}
            })

	addToSelection: (event) ->
		self = @
		checkbox = $(@el).find('.icon-check')
		checkbox.removeClass('unselected').addClass('icon-darkblue selected')
		batch_collection.add(@model)

	removeFromSelection: (event) ->
		self = @
		checkbox = $(event.currentTarget)
		checkbox.removeClass('icon-darkblue selected').addClass('unselected')
		batch_collection.remove(@model)

	loadFunctions: (event) ->
		$('#inventory-table_wrapper .icon-search').removeClass('icon-darkblue')
		$(@el).find('.icon-check').addClass('icon-darkblue')

		functions_view = new Bluebase.Views.ItemsFunctions(model: @model)
		if views_bucket.length
			existing_view = views_bucket[views_bucket.length - 1]
			existing_view.close()
		views_bucket.push(functions_view)
		$('#right').html(functions_view.render().el).fadeIn()
		Backbone.ModelBinding.bind(this)