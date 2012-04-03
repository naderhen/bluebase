class Bluebase.Views.Item extends Backbone.View
	template: JST['items/item']
	tagName: 'tr'

	events: 
		'click .unselected': 'addToSelection'
		'click .selected': 'removeFromSelection'
		'click .icon-search': 'loadFunctions'

	initialize: ->
		@model.on('change', @render, this)
		@model.on('sync', @savedItem, this)
		@model.on('faye:update', @fayeUpdate, this)
		@batch_collection = @.options.batch_collection

	render: ->
		purchaseorder = @.options.purchaseorder
		$(@el).html(@template({item: @model, purchaseorder: purchaseorder}))
		if @model.hasChanged()
		  $(@el).addClass('changed')
		Backbone.ModelBinding.bind(this)
		this

	fayeUpdate: (data) ->
		@model.set(data.model)
		comment = $(@el).find('.icon-comment')
		$(@el).addClass('fayeUpdated').removeClass('changed')
		comment.attr({
			rel: "tooltip"
			title: "Edited by: " + data.user.name
			}).tooltip().fadeIn()
		sticky_text = "#{data.user.name} updated PO# #{@model.get('po_number')} #{@model.get('box_number')} - #{@model.get('item_number')}"
		$.sticky(sticky_text)

	savedItem: ->
		$(@el).removeClass('changed highlight')
		$(@el).find('.icon-ok').fadeIn();
		faye.publish('/items/update', {"model": @model, "user": user})

	addToSelection: (event) ->
		self = @
		checkbox = $(event.currentTarget)
		checkbox.removeClass('unselected').addClass('icon-darkblue selected')
		@batch_collection.add(@model)

	removeFromSelection: (event) ->
		self = @
		checkbox = $(event.currentTarget)
		checkbox.removeClass('icon-darkblue selected').addClass('unselected')
		@batch_collection.remove(@model)

	loadFunctions: (event) ->
		$('#inventory-table_wrapper .icon-search').removeClass('icon-darkblue')
		$(event.currentTarget).addClass('icon-darkblue')
		functions_view = new Bluebase.Views.ItemsFunctions(model: @model)
		$('#right').html(functions_view.render().el).fadeIn()
		Backbone.ModelBinding.bind(this)

		row = $(@el)
		row.siblings().removeClass('highlight')
		row.addClass('highlight')