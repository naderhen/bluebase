class Bluebase.Views.ItemsFunctions extends Backbone.View
	template: JST['items/functions']

	events:
		'submit': 'save'

	render: ->
		species = @model.get('species').toLowerCase()
		
		grade_options = tail_grade_options = freshness_grade_options = texture_grade_options = []

		grade_options = ["1++", "1+", "1", "1-", "2+", "2H", "2G", "2", "2-", "3", "4"]
		freshness_grade_options = ["A+", "A", "B+", "B", "B-", "C+", "C", "C-"]
		texture_grade_options = ["A+", "A", "B+", "B", "B-", "C+", "C", "C-"]

		switch species
			when "tuna"
				grade_options = ["1++", "1+", "1", "1-", "2+", "2H", "2G", "2", "2-", "3", "4"]
				tail_grade_options = ["1++", "1+", "1", "1-", "2+", "2H", "2G", "2", "2-", "3", "4"]
				tag_options = ["Blood", "Lots of Blood", "Little Blood", "Rainbow", "Smell", "Soft", "Very Soft", "Burn", "2 Color", "Yellow", "Damage", "FDA", "Light", "Sashi", "Sick", "Dark", "Eggs"]
			when "swordfish", "swordfish*", "swordfish**", "swordfish***", "swordfish+"
				grade_options = ["R+", "R", "R-", "Brown", "Burgundy", "Pumpkin", "Salmon"]
				tag_options = ["Tumor", "Soft", "Damage", "Smell", "FDA", "1/2 Fish", "Head", "Tail", "Scar", "Worms"]
			else
				tag_options = ["Damage", "Smell", "FDA"]

		$(@el).html(@template({item: @model, tag_options: tag_options, tagged: @model.get('tag_list'), grade_options: grade_options, tail_grade_options: tail_grade_options, freshness_grade_options: freshness_grade_options, texture_grade_options: texture_grade_options}))
		Backbone.ModelBinding.bind(this)
		this

	save: (event) ->
		checked_tags = _.pluck(@$("input.tag_list_check:checked"), 'value')
		@model.set('tag_list', checked_tags)
		console.log(@model)
		@model.save
			success: ->
				@model.trigger('change')
		event.preventDefault()