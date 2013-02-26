bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.start = ()->
  bloodTorrent.donationRequest.controller
    views:
      requestList: calatrava.bridge.pages.pageNamed "requestList"
      requestDetail: calatrava.bridge.pages.pageNamed "requestDetail"
      addRequest: calatrava.bridge.pages.pageNamed "addRequest"
    repositories:
      donationSearch: bloodTorrent.donationRequest.donationRequestRepository()
    changePage: calatrava.bridge.changePage

  calatrava.bridge.changePage "requestList"
