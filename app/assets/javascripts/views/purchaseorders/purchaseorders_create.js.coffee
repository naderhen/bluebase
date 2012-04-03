class Bluebase.Views.PurchaseordersCreate extends Backbone.View

	template: JST['purchaseorders/create']

	events:
		'click .save': 'save'

	initialize: ->
		@model.on('sync', @showUploadForm, this)

	render: ->
		me = @
		self = this

		$(me.el).html(me.template(model: me.model, shippers_collection: shippers))
		$(me.el).modal()
		$('.datepicker').datepicker({
			dateFormat: 'yy-mm-dd'
		})
		Backbone.ModelBinding.bind(me)
		Backbone.Validation.bind this,
			valid: (view, attr) ->
				
			invalid: (view, attr, error) ->
				

		this
	
	save: ->
		if @model.isValid()
			@model.save()

	showUploadForm: ->
		upload_view = new Bluebase.Views.PurchaseorderUpload(model: @model)
		@$('#upload-container').hide().html(upload_view.render().el).slideDown('slow')
		$("#progress-instructions").html("PO ##{@model.get('id')} saved! Upload an inventory CSV.")
		$("#progress-bar").parents('.progress').removeClass('progress-danger').addClass('progress-warning')
		$("#progress-bar").animate({width: '66%'})
		$("#modal-bottom").slideUp('slow')
