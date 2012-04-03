class Bluebase.Models.Item extends Backbone.Model
	url: ->
		base = 'api/items'
		if this.isNew()
			base
		else
			base + '/' + this.id;

	urlRoot: 'api/items'