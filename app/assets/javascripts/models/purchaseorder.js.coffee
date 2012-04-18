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

	export: ->
		(@sync || Backbone.sync).call @, 'export', @,
			url: "#{@url()}/export"
			success: (data) =>
				console.log data

	url: ->
		base = 'api/purchaseorders'
		if this.isNew()
			base
		else
			base + '/' + this.id;

	urlRoot: 'api/purchaseorders'

