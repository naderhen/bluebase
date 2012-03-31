class Bluebase.Models.User extends Backbone.Model
	url: -> 
		'/api/users/' + this.id