class Bluebase.Views.PurchaseorderInfo extends Backbone.View

	template: JST['purchaseorders/info']

	render: ->
		me = @
		self = this
		model = @model


		$(me.el).html(me.template(model: model))
		Backbone.ModelBinding.bind(self)

		comments_collection = new Bluebase.Collections.Comments
		if (model.get('root_comments').length > 0)
			comments_collection.reset(model.get('root_comments'))
		$(me.el).find('#comments-count').html(comments_collection.length)
		comments_view = new Bluebase.Views.CommentsIndex({collection: comments_collection, parent_model: model, parent_type: "Purchaseorder"} )
		$(me.el).find('#comments-container').html(comments_view.render().el)
		
		this