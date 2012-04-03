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
		@collection.each(@appendDraftItem)
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