bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.controller = ({views, repositories, changePage, ajax}) ->

  fetchMatchingDonationRequests = () ->
    donationRequests = repositories.donationSearch.get
      searchParams : {blood_group:"apositive"}
      ifSucceded: (response) ->
        views.requestList.render
          requestList: response
          

  renderDonationRequestList = () ->
    _.map donationRequests, (c) ->
      id: c.id,
      blood_group: c.blood_group,
      quantity: c.quantity,
      contact_details: contact_details

  getRequestDetail = (requestId) ->
    {id: 1, blood_group: "O+", quantity:"200ml", latitude:18.5236 , longitude:73.8478, contact_details: "+919923700612"}

  show = (requestId) ->
    calatrava.bridge.changePage "requestDetail"
    views.requestDetail.render
      requestDetail: getRequestDetail(requestId)

  views.requestList.bind 'donationRequest', show

  initialize = () ->
    fetchMatchingDonationRequests()

  initialize()
