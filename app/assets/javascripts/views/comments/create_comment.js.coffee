class Bluebase.Views.CreateComment extends Backbone.View

	template: JST['comments/create']

	events: 
		'click .save-comment': 'saveComment'

	initialize: ->
		@model.on('sync', @addToCollection, this)

	render: ->
		me = @
		$(@el).html(@template())
		this

	saveComment: ->
		@model.set({
			model_type: @options.parent_type
			model_id: @options.parent_model.get('id')
			body: @$('#comment-text').val()
		})
		@model.save()

	addToCollection: (comment) ->
		@collection.add(@model)
		@undelegateEvents()
		@remove()