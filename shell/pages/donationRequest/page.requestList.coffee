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
    console.log "event: #{event}"
    selector = "." + event
    $page.on 'click', selector, (e) -> handler($(this).data('request-id'))

  render: (message) ->
    console.log('rendering...', message)
    renderSection(section, data) for own section,data of message

  get: (field) ->
    console.log('getting...', field)
    $page.find("#" + field).val()

  show: ->
    console.log('showing...')
    $page.show()

  hide: ->
    console.log('hiding...')
    $page.hide()
