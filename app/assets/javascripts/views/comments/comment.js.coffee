class Bluebase.Views.Comment extends Backbone.View
	template: JST['comments/comment']

	initialize: ->
		model = @model
		@model.on('change', @render, this)
		@model.set('user_name', _.find(all_users, (user) -> user.id == model.get('user_id') ).name)

	render: ->
		$(@el).html(@template({comment: @model}))
		this