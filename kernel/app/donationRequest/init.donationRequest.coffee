bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.start = ->
  bloodTorrent.donationRequest.controller
    views:
      requestList: calatrava.bridge.pages.pageNamed "requestList"
      requestDetail: calatrava.bridge.pages.pageNamed "requestDetail"
    changePage: calatrava.bridge.changePage
    ajax: calatrava.bridge.request

  calatrava.bridge.changePage "requestList"
