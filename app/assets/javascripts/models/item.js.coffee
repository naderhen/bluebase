class Bluebase.Models.Item extends Backbone.Model
	url: -> 
		'/api/items/' + this.id