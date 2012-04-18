class Bluebase.Views.PurchaseorderUploadTable extends Backbone.View

	template: JST['purchaseorders/upload_table']

	events:
		'click #confirm-inventory': 'uploadInventory'

	initialize: ->
		$("#progress-instructions").html("CSV Uploaded but NOT saved yet. Please review and click Confirm!")
		$("#progress-bar").parents('.progress').removeClass('progress-warning')
		$("#progress-bar").animate({width: '85%'})

	render: ->
		$(@el).html(@template(collection: @collection))
		$('.modal').animate({ width: '1000px', marginLeft: '-500px' })
		@collection.each(@appendDraftItem)

		total_pounds = 0
		_.reduce @collection.models, (i, model) ->
			total_pounds += parseFloat(model.get('weight'))
		$(@el).find('#total-pounds').html(total_pounds)
		this

	appendDraftItem: (item) =>
		view = new Bluebase.Views.DraftItem({model: item})
		@$('table tbody').append(view.render().el)

	uploadInventory: (event) ->
		$.each @collection.models, (i, model) ->
			model.save()
		$("#progress-instructions").html("Inventory successfully added to Purchaseorder! You're Done!")
		$("#progress-bar").parents('.progress').addClass('progress-success')
		$("#progress-bar").animate({width: '100%'})
		$("#modal-bottom").find('.save').hide()
		$("#modal-bottom").slideDown('slow')