class Bluebase.Views.CommentsIndex extends Backbone.View

	template: JST['comments/index']

	events: 
		'click .create-comment': 'createComment'

	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('add', @appendItem, this)

	render: ->
		me = @
		$(@el).html(@template())
		@collection.each(@appendItem)
			
		this

	appendItem: (comment) =>
		view = new Bluebase.Views.Comment({model: comment})
		@$('#purchaseorder-comments').append(view.render().el)

	createComment: ->
		comment = new Bluebase.Models.Comment
		create_comment_view = new Bluebase.Views.CreateComment({model: comment, collection: @collection, parent_model: @options.parent_model, parent_type: @options.parent_type})
		@$('#create-comment-container').html(create_comment_view.render().el).slideDown('slow')