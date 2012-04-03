class Bluebase.Views.DraftItem extends Backbone.View
	template: JST['items/draft_item']
	tagName: 'tr'

	render: ->
		$(@el).html(@template({item: @model}))
		this