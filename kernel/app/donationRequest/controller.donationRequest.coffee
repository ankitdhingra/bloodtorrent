bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.controller = ({views, repositories, changePage}) ->

  donationRequests = null

  fetchMatchingDonationRequests = () ->
    repositories.donationSearch.get
      searchParams : {blood_group:"apositive", latitude: 18,longitude:73,radius: 1000}
      ifSucceded: (response) ->
        donationRequests = response
        views.requestList.render
          requestList: response

  getRequestDetail = (requestId) ->
    requestDetail = _.find(donationRequests, (object) ->
      return requestId == object['id']
    )
    requestDetail ?= {}
    requestDetail

  show = (requestId) ->
    calatrava.bridge.changePage "requestDetail"
    views.requestDetail.render
      requestDetail: getRequestDetail(requestId)

  views.home.bind 'goHome', () -> calatrava.bridge.changePage "home"
  views.home.bind 'addDonationRequestBtn', () -> calatrava.bridge.changePage "addRequest"
  views.home.bind 'viewDonationListBtn', () -> calatrava.bridge.changePage "requestList"
  views.requestList.bind 'donationRequest', show

  initialize = () ->
    fetchMatchingDonationRequests()

  initialize()
