class Bluebase.Views.History extends Backbone.View
	template: JST['history/history']

	initialize: ->
		model = @model
		@model.on('change', @render, this)
		if model.get('created_by')
			@model.set('user_name', _.find(all_users, (user) -> user.id == parseInt(model.get('created_by')) ).name)

	render: ->
		me = @
		$(@el).html(@template({history: @model}))
		$.each @model.attributes, (key, value) ->
			if _.indexOf(["core_grade", "freshness_grade", "texture_grade", "tail_grade"], key) > -1
				if value[0]
					string = "#{value[0]} => #{value[1]}"
				else
					string = "#{value[1]}"
				$(me.el).find('.change-list').append("<li>#{key}: #{string}</li>")
		this