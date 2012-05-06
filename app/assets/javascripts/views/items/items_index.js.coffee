class Bluebase.Views.ItemsIndex extends Backbone.View

	template: JST['items/index']

	events:
		'click .batch-edit': 'batchEdit'
		'click .clear-batch': 'clearBatch'
		'click .filter-checkbox': 'checkboxFilter'

	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('add', @appendItem, this)
		batch_collection.on('add remove reset', @updateBatch, this)

		collection = @collection
		PUBNUB.subscribe({
			channel: 'items_update',
			callback: (data) ->
				model = data.model
				updated_model = collection.get(model.id)
				if typeof(updated_model != 'undefined')
					updated_model.trigger('pubnub:update', data)
			})

	render: ->
		me = @
		purchaseorder = @.options.purchaseorder
		core_grade_choices = ["All", "1++", "1+", "1", "1-", "2+", "2H", "2G", "2H", "2G", "2-", "3", "4"]
		freshness_grade_choices = ["All", "A+", "A", "B+", "B", "B-", "C+", "C", "C-"]
		$(@el).html(@template(purchaseorder: purchaseorder, batch_collection: batch_collection, core_grade_choices: core_grade_choices, freshness_grade_choices: freshness_grade_choices))
		@collection.each(@appendItem)

		items_table = @$('table').dataTable({
			"sDom": 'W<"clear">Rlfrtipz',
			"sPaginationType": "bootstrap",
			"oLanguage": {
		  	"sLengthMenu": "_MENU_ records per page"
			},

			"iDisplayLength": 35,
			"aaSorting": [[2, "asc"], [3, "asc"]]
		});

		@$('table').selectable
			filter: 'tr',
			stop: (event, ui) ->
				selected_items = me.$('.ui-selected')
				if selected_items.length > 1
					batch_collection.reset()
					me.$('table').find('.icon-check.icon-darkblue').removeClass('icon-darkblue')
					selected_items.trigger('addToSelection')
				else
					batch_collection.reset()
					me.$('table').find('.icon-check.icon-darkblue').removeClass('icon-darkblue')
					selected_items.trigger('loadFunctions')

		@$("#weight-range").slider
			range: true
			min: 0
			max: 300
			values: [ 75, 225 ]
			slide: (event, ui) ->
				$('#weight-results').html("#{ui.values[0]} - #{ui.values[1]}")
				items_table.addClass('filter-weight')
				items_table.fnDraw();

		# @$('.filter-widget').on 'blur', ->
		# 	col_index = $(this).attr('data-column')

		# 	items_table.fnFilter("^(0{0,2}[0-9]|0?[1-9][0-9]|1[0-7][0-9]|180)$", 4, true)

		# 	if	$(this).val().length > 0
		# 		filter_value = "^" + $(this).val() + "$"
		# 		items_table.fnFilter(filter_value, col_index, true)
		# 	else
		# 		items_table.fnFilter('', col_index)
			
		this

	checkboxFilter: (e) ->
		element = $(e.currentTarget)
		items_table = @$('#inventory-table').dataTable()
		items_table.addClass(element.attr('data-filter-type'))
		if element.val() == "All"
		  $('.' + element.attr('data-filter-type')).prop('checked', element.prop('checked'))
		else
		  $('#' + element.attr('data-filter-type') + '-All').prop('checked', false)
		items_table.fnDraw()

	appendItem: (item) =>
		purchaseorder = @.options.purchaseorder
		view = new Bluebase.Views.Item({model: item, collection: @collection, purchaseorder: purchaseorder, batch_collection: batch_collection})
		@$('table tbody').append(view.render().el)

	updateBatch: (event) ->
		@$('.batch-edit').find('span').html(batch_collection.length)

	batchEdit: (event) ->
		batch_edit_view = new Bluebase.Views.ItemsBatchEdit(batch_collection: batch_collection)
		batch_edit_view.render()
		event.preventDefault()

	clearBatch: (event) ->
		batch_collection.reset()
		@$('.selected').removeClass('icon-darkblue selected').addClass('unselected')
		event.preventDefault()