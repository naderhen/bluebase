class Bluebase.Views.ItemsBatchEdit extends Backbone.View

	template: JST['items/batch_edit']

	events:
		'click #submit-batch': 'save'

	initialize: ->

	render: ->
		tag_options = ["Blood", "Lots of Blood", "Little Blood", "Tumor", "1/2 Fish", "Head", "Tail", "Scar", "Worms", "Rainbow", "Smell", "Soft", "Very Soft", "Burn", "2 Color", "Yellow", "Damage", "FDA", "Light", "Sashi", "Sick", "Dark", "Eggs"]

		$(@el).html(@template(collection: batch_collection, tag_options: tag_options))
		$(@el).modal()
		this

	save: (event) ->
		checked_tags = _.pluck(@$("input.tag_list_check:checked"), 'value')

		$.each batch_collection.models, (i, model) ->
			model.set('tag_list', checked_tags)
			model.save()
		$(@el).find('#close-modal').click()
		event.preventDefault()