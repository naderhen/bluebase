class Bluebase.Views.HistoryIndex extends Backbone.View
	template: JST['history/index']

	render: ->
		me = @
		$(@el).html(@template())
		@collection.each(@appendItem)

		this

	appendItem: (comment) =>
		view = new Bluebase.Views.History({model: comment})
		@$('#history-list').append(view.render().el)