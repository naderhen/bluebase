class Bluebase.Models.Purchaseorder extends Backbone.Model
	validation : {
		po_number: {
			required: true,
			msg: "PO # is required!"
		},
		po_date: {
			required: true, 
			msg: "PO Date is required!"
		}
	}

	url: ->
		base = 'api/purchaseorders'
		if this.isNew()
			base
		else
			base + '/' + this.id;

	urlRoot: 'api/purchaseorders'

