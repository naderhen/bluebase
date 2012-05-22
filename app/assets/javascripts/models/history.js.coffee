class Bluebase.Models.History extends Backbone.Model
	url: ->
		base = 'api/histories'
		if this.isNew()
			base
		else
			base + '/' + this.id;

	urlRoot: 'api/histories'