class Bluebase.Views.PurchaseordersIndex extends Backbone.View

	template: JST['purchaseorders/index']

	events:
		'click #create_purchaseorder': 'createPurchaseorder'
	
	initialize: ->
		@collection.on('reset', @render, this)

		PUBNUB.subscribe({
			channel: 'grading_complete',
			callback: (data) ->
				console.log(data)
				$.sticky("#{data.user.name} says that PO##{data.po_number} grading is complete!!")
			})

	render: ->
		$(@el).html(@template())
		@collection.each(@appendPurchaseorder)
		purchaseorders_table = @$('table').dataTable( {
			"sDom": "<'row'<'span5'l><'span5'f>r>t<'row'<'span5'i><'span5'p>>",
			"sPaginationType": "bootstrap",
			"oLanguage": {
				"sLengthMenu": "_MENU_ records per page"
			}
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