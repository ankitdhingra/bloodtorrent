bloodTorrent ?= {}
bloodTorrent.donationRequest ?= {}

bloodTorrent.donationRequest.donationRequestRepository = () ->
 
  stringifySearchParams: (options) ->
    paramsString = ""
    paramKeys = _.keys(options)
    _.each(paramKeys, (paramKey)=>
      paramsString = paramsString + paramKey + "=" + options[paramKey] + "&"
    )
    paramsString.substring(0, paramsString.length - 1)

  extractRequestFrom: (responseData) ->
    _.map JSON.parse(responseData), (request) ->
      id: request._id
      blood_group: request.blood_group
      quantity: request.quantity
      contact_details: request.contact_details
      latitude: request.coordinates[0]
      longitude: request.coordinates[1]
    
  get: (options) ->
    apiName = "donation/search"
    calatrava.bridge.request
      url: "http://localhost:8888/api/#{apiName}"
      method: 'GET'
      body: @stringifySearchParams(options.searchParams)
      success: (responseData) =>
        response = JSON.parse responseData
        options.ifSucceded @extractRequestFrom(responseData)
      failure: (errorCode) ->
        options.elseFailed errorCode.toString()


