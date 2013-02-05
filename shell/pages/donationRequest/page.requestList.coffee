calatrava.pageView ?= {}

calatrava.pageView.requestList = ->

  #TODO: refactor out
  $page = $('#requestList')
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
    $p("." + event).off('click').on 'click', handler

  render: (message) ->
    console.log('rendering...', message)
    renderSection(section, data) for own section,data of message

  get: (field) ->
    console.log('getting...', field)
    $page.find("#" + field).val()

  show: -> console.log('showing...')
  hide: -> console.log('hiding...')
