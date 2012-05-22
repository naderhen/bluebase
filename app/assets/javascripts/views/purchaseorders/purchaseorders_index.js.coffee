class Bluebase.Views.PurchaseordersIndex extends Backbone.View

	template: JST['purchaseorders/index']

	events:
		'click #create_purchaseorder': 'createPurchaseorder'
	
	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('change', @render, this)
		PUBNUB.subscribe({
			channel: 'grading_complete',
			callback: (data) ->
				$.sticky("#{data.user.name} says that PO##{data.po_number} grading is complete!!")
			})

	render: ->
		console.log('rendering')
		$(@el).html(@template())
		@collection.each(@appendPurchaseorder)
		purchaseorders_table = @$('table').dataTable( {
			"sDom": "<'row'<'#po_length_select'l><'#po_search'f>r>t<'row'<'span5'i><'span5'p>>",
			"sPaginationType": "bootstrap",
			"oLanguage": {
				"sLengthMenu": "_MENU_"
			},
			"aaSorting": [[1, "desc"]]
		});

		this

	appendPurchaseorder: (purchaseorder) =>
		view = new Bluebase.Views.Purchaseorder({model: purchaseorder})
		@$('table tbody').append(view.render().el)

	createPurchaseorder: (event) ->
		@purchaseorder = new Bluebase.Models.Purchaseorder
		create_view = new Bluebase.Views.PurchaseordersCreate(model: @purchaseorder)
		create_view.render()
		event.preventDefault()