package com.calatrava.bridge;

import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;
import com.calatrava.CalatravaPlugin;

import android.content.Context;
import android.content.Intent;
import org.codehaus.jackson.map.ObjectMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CalatravaPlugin(name = "geolocation")
public class GeolocationPlugin implements RegisteredPlugin
{
    private PluginRegistry registry;
    private Context ctxt;
    private String successCallback;
    private String failureCallback;

    public void setContext(PluginRegistry registry, Context ctxt)
    {
        this.registry = registry;
        this.ctxt = ctxt;
        Log.d(GeolocationPlugin.class.getSimpleName(), "<<<<<<<<<<<<<<<<<< Installiing Geolocation >>>>>>>>>>>>>>>>>>>>>");
        registry.installCommand("geolocation", new PluginCommand() {
            @Override
            public void execute(Intent action, RegisteredActivity frontmost) {
                // Acquire a reference to the system Location Manager
                LocationManager locationManager = (LocationManager) GeolocationPlugin.this.ctxt.getSystemService(Context.LOCATION_SERVICE);

                // Define a listener that responds to location updates
                LocationListener locationListener = new LocationListener() {
                    public void onLocationChanged(Location location) {
                        // Called when a new location is found by the network location provider.
                        Log.d(GeolocationPlugin.class.getSimpleName(), "<<<<<<<<<<<<<<<<<< Location Changed !!! >>>>>>>>>>>>>>>>>");
                        Map<String, Object> geolocation = new HashMap<String, Object>();
                        HashMap<String, String> coords = new HashMap<String, String>();

                        coords.put("latitude", String.valueOf(location.getLatitude()));
                        coords.put("longitude", String.valueOf(location.getLongitude()));
                        geolocation.put("coords", coords);
                        GeolocationPlugin.this.registry.invokeCallback(successCallback, geolocation);
                    }

                    public void onStatusChanged(String provider, int status, Bundle extras) {}

                    public void onProviderEnabled(String provider) {}

                    public void onProviderDisabled(String provider) {}
                };

                // Register the listener with the Location Manager to receive location updates

//                for (String provider : locationManager.getProviders(true)) {
                    Log.d(GeolocationPlugin.class.getSimpleName(), "<<<<<<<<<<<<<<<<<< Requesting Location to GPS Provider >>>>>>>>>>>>>>>>>");
                    locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, locationListener);
//                }
            }
        });
    }

    public void call(String method, Map<String, Object> args)
    {
        successCallback = (String)args.get("successCallbackHandle");
        failureCallback = (String)args.get("failureCallbackHandle");
        Log.d(GeolocationPlugin.class.getSimpleName(), "<<<<<<<<<<<<<<<<<< Calling Geolocation >>>>>>>>>>>>>>>>>");
        ctxt.sendBroadcast(registry.pluginCommand("geolocation"));
    }
}
