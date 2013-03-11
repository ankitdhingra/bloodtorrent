calatrava.geolocation = (successCallback, failureCallback) ->
  successCallbackHandle = calatrava.bridge.plugins.rememberCallback(successCallback)
  failureCallbackHandle = calatrava.bridge.plugins.rememberCallback(failureCallback)
  calatrava.bridge.plugins.call 'geolocation', 'geolocation',
    successCallbackHandle: successCallbackHandle,
    failureCallbackHandle: failureCallbackHandle

