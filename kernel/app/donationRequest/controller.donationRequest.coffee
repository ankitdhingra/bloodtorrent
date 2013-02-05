bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.controller = ({views, changePage, ajax}) ->
  donationRequests = [
    {id: 1, blood_group: "O+", quantity:"200ml", latitude:18.5236 , longitude:73.8478, contact_details: "+919923700612"},
    {id: 2, blood_group: "B+", quantity:"300ml", latitude:18.5236 , longitude:73.8478, contact_details: "priyank@mailinator.com"},
    {id: 3, blood_group: "A-", quantity:"500ml", latitude:18.5236 , longitude:73.8478, contact_details: "akshay@twitter"},
  ]

  getDonationRequests = () ->
    _.map donationRequests, (c) ->
      id: c.id,
      blood_group: c.blood_group,
      quantity: c.quantity

  getRequestDetail = (requestId) ->
    {id: 1, blood_group: "O+", quantity:"200ml", latitude:18.5236 , longitude:73.8478, contact_details: "+919923700612"}

  show = (requestId) ->
    calatrava.bridge.changePage "requestDetail"
    views.requestDetail.render
      requestDetail: getRequestDetail(requestId)

  views.requestList.bind 'donationRequest', show

  views.requestList.render
    requestList: getDonationRequests()
