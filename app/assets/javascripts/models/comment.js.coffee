class Bluebase.Models.Comment extends Backbone.Model
	url: ->
		base = 'api/comments'
		if this.isNew()
			base
		else
			base + '/' + this.id;

	urlRoot: 'api/comments'