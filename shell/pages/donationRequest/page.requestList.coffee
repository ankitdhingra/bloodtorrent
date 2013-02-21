calatrava.pageView ?= {}

calatrava.pageView.requestList = ->

  #TODO: refactor out
  page_id = '#requestList'
  $page = $(page_id)
  $p = (sel)-> $(sel, $page)

  renderRequestList = ($ul, donationRequests)->
    $ul.empty().html ich.donationRequestTmpl
      donationRequests: donationRequests

  renderSection = (key, data) ->
    switch key
      when 'requestList' then renderRequestList($p('#request_list'), data)
      else $p("#" + key).val(data)

  bind: (event, handler) ->
    selector = "." + event
    $page.on 'click', selector, (e) -> handler($(this).data('request-id'))

  render: (message) ->
    renderSection(section, data) for own section,data of message

  get: (field) ->
    $page.find("#" + field).val()

  show: ->
    $page.show()

  hide: ->
    $page.hide()
