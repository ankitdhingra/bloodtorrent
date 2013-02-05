bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.controller = ({views, changePage, ajax}) ->
  donationRequests = [{group: "O+", quantity:"200ml" }, {group: "B+", quantity:"300ml" }, {group: "A+", quantity:"500ml" }]

  getDonationRequests = () ->
    _.map donationRequests, (c) ->
      group: c.group,
      quantity: c.quantity

  getRequestDetail = (requestId) ->
    {group: "O+", quantity: "200ml", phoneNumber: "76568765"}

  show = (requestId) ->
    views.requestDetail.render
      requestDetail: getRequestDetail(requestId)

  views.requestList.bind 'donation-request', show


  views.requestList.render
    requestList: getDonationRequests()
