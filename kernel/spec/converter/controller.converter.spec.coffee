exports = require 'spec_helper'

example = exports.bloodTorrent
stubView = exports.stubView

describe 'donationRequest controller', ->
  ajax = null
  changePage = null
  views = null

  beforeEach ->
    ajax = jasmine.createSpy("ajax requester")
    changePage = jasmine.createSpy('page changer').andCallFake (targetPage) ->
      if views[targetPage].boundEvents['pageOpened']?
        views[targetPage].trigger 'pageOpened'
    views =
      requestList: stubView.create('donationRequestForm')

    subject = bloodTorrent.donationRequest.controller
      changePage: changePage
      views: views
      ajax: ajax

  it 'should bind the convert event', ->
    expect(views.requestList.boundEvents['convert']).not.toBeUndefined()

  describe 'converting', ->

    beforeEach ->
      views.requestList.fieldContains 'in_currency', 'USD'
      views.requestList.fieldContains 'out_currency', 'AUD'
      views.requestList.fieldContains 'in_amount', 100
      views.requestList.trigger 'convert'

    it 'should render the correctly converted amount', ->
      expect(views.requestList.render).toHaveBeenCalledWith
        out_amount: 96
