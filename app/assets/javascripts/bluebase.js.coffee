window.Bluebase =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
  	new Bluebase.Routers.Inventory
  	Backbone.history.start()

$(document).ready ->
  Bluebase.init()

  $('.dropdown-toggle').dropdown()

  $(document).ajaxSend (e, xhr, options) ->
    token = $("meta[name='csrf-token']").attr("content")
    xhr.setRequestHeader "X-CSRF-Token", token