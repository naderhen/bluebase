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
			when "swordfish", "swordfish*", "swordfish**", "swordfish***", "swordfish+"
				grade_options = ["R+", "R", "R-", "Brown", "Burgundy", "Pumpkin", "Salmon"]

		$(@el).html(@template({item: @model, grade_options: grade_options, tail_grade_options: tail_grade_options, freshness_grade_options: freshness_grade_options, texture_grade_options: texture_grade_options}))
		Backbone.ModelBinding.bind(this)
		this

	save: (event) ->
		@model.save
			success: ->
				@model.trigger('change')
		event.preventDefault()