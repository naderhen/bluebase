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
				
				comments_collection = new Bluebase.Collections.Comments
				if (model.get('root_comments').length > 0)
					comments_collection.reset(model.get('root_comments'))
				comments_view = new Bluebase.Views.CommentsIndex({collection: comments_collection, parent_model: model, parent_type: "Purchaseorder"} )
				$(me.el).find('#comments-container').html(comments_view.render().el)
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
