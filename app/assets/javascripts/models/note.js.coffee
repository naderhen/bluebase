class Bluebase.Models.Note extends Backbone.Model
	url: -> 
		'/api/notes/' + this.id