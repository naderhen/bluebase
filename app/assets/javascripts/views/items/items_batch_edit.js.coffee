class Bluebase.Views.ItemsBatchEdit extends Backbone.View

	template: JST['items/batch_edit']

	initialize: ->
		@batch_collection = @.options.batch_collection

	render: ->
		$(@el).html(@template(collection: @batch_collection))
		$(@el).modal()
		this