bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.controller = ({views, repositories, changePage}) ->

  donationRequests = null

  fetchMatchingDonationRequests = (geolocation) ->
    repositories.donationSearch.get
      searchParams : {blood_group:"apositive", latitude: geolocation.coords.latitude,longitude: geolocation.coords.longitude,radius: 1000}
      ifSucceded: (response) ->
        donationRequests = response
        views.requestList.render
          requestList: response
      elseFailed: calatrava.alert

  getRequestDetail = (requestId) ->
    requestDetail = _.find(donationRequests, (object) ->
      return requestId == object['id']
    )
    requestDetail ?= {}
    requestDetail

  show = (requestId) ->
    views.requestDetail.bind 'pageOpened', () -> renderRequestDetail(requestId)
    changePage "requestDetail"

  renderRequestDetail = (requestId) ->
    views.requestDetail.render
      requestDetail: getRequestDetail(requestId)

  views.home.bind 'goHome', () -> changePage "home"
  views.home.bind 'addDonationRequestBtn', () -> changePage "addRequest"
  views.home.bind 'viewDonationListBtn', () -> changePage "requestList"
  views.requestList.bind 'donationRequest', show

  views.home.bind 'pageOpened', () -> calatrava.geolocation(fetchMatchingDonationRequests, () -> calatrava.alert('Geolocation Not Supported'))

  initialize = () ->
    changePage "home"

  initialize()
