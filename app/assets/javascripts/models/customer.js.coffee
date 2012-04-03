class Bluebase.Models.Customer extends Backbone.Model
	url: -> 
		'/api/customers/' + this.id