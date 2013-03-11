calatrava.web ?= {}

calatrava.web.geolocation = (method, { successCallbackHandle, failureCallbackHandle}) ->
  geo = navigator.geolocation if window.navigator && navigator.geolocation
  geo = google.gears.factory.create('beta.geolocation') if window.google && google.gears
  return calatrava.bridge.runtime.invokePluginCallback(failureCallbackHandle) if not geo
  geo.getCurrentPosition((coordinates) -> calatrava.bridge.runtime.invokePluginCallback(successCallbackHandle, coordinates),
  () -> calatrava.bridge.runtime.invokePluginCallback(failureCallbackHandle),
  {enableHighAccuracy: true})

calatrava.bridge.runtime.registerPlugin 'geolocation', calatrava.web.geolocation
