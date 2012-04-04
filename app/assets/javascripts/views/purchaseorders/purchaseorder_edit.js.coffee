class Bluebase.Views.PurchaseorderEdit extends Backbone.View

	template: JST['purchaseorders/edit']

	events: 
		'click .submit-edit': 'edit'
		'click #mark-as-graded': 'markAsGraded'

	render: ->
		me = @
		self = this
		model = me.model

		model.fetch({
			success: ->
				$(me.el).html(me.template(model: model, shippers_collection: shippers))
				Backbone.ModelBinding.bind(self)
				$(me.el).modal()
		})
		this

	markAsGraded: (event) ->
		@model.set({graded: true})
		@model.save()
		
		PUBNUB.publish({
        	channel : "grading_complete",
        	message : {"po_number": @model.get('po_number'), "user": user}
    	})

	edit: (event) ->
		@model.save()
