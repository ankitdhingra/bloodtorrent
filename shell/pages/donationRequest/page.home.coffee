calatrava.pageView ?= {}

calatrava.pageView.home = ->

  #TODO: refactor out
  page_id = '#home'
  $page = $(page_id)
  $p = (sel)-> $(sel, $page)

  bind: (event, handler) ->
    selector = "#" + event
    if event is "goHome"
      $(selector).on 'click', selector, (e) -> handler()
    else
      $page.on 'click', selector, (e) -> handler()

  get: (field) ->
    $page.find("#" + field).val()

  show: ->
    $("#goHome").hide()
    $page.show()

  hide: ->
    $("#goHome").show()
    $page.hide()
