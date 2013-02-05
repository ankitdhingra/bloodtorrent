calatrava.pageView ?= {}

calatrava.pageView.requestDetail = ->

  #TODO: refactor out
  $page = $('#requestDetail')
  $p = (sel)-> $(sel, $page)

  renderRequestDetail = ($dl, requestDetail)->
    $dl.empty().html ich.requestDetailTmpl
      requestDetail: requestDetail

  renderSection = (key, data) ->
    renderRequestDetail($p('#request_detail'), data)

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
