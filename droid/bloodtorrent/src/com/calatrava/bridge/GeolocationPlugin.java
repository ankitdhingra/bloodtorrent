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
    public static final String TAG = GeolocationPlugin.class.getSimpleName();
    private PluginRegistry registry;
    private Context ctxt;
    private String successCallback;
    private String failureCallback;

    public void setContext(PluginRegistry registry, Context ctxt)
    {
        this.registry = registry;
        this.ctxt = ctxt;
        Log.d(TAG, "<<<<<<<<<<<<<<<<<< Installiing Geolocation >>>>>>>>>>>>>>>>>>>>>");
        registry.installCommand("geolocation", new PluginCommand() {
            @Override
            public void execute(Intent action, RegisteredActivity frontmost) {
                Location location = getBestLocation();
                Log.d(TAG, "<<<<<<<<<<<<<<<<<< Location Changed !!! >>>>>>>>>>>>>>>>>");
                Log.d(TAG, "<<<<<<<<<<<<<<The Accuracy is: " + location.getAccuracy() + ">>>>>>>>>>>>>>>>");
                Map<String, Object> geolocation = new HashMap<String, Object>();
                HashMap<String, String> coords = new HashMap<String, String>();

                coords.put("latitude", String.valueOf(location.getLatitude()));
                coords.put("longitude", String.valueOf(location.getLongitude()));
                geolocation.put("coords", coords);
                GeolocationPlugin.this.registry.invokeCallback(successCallback, geolocation);
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


    private Location getBestLocation() {
        Location gpslocation = getLocationByProvider(LocationManager.GPS_PROVIDER);
        Location networkLocation = getLocationByProvider(LocationManager.NETWORK_PROVIDER);


        //if we have only one location available, the choice is easy
        if (gpslocation == null) {
            Log.d(TAG, "No GPS Location available.");
            return networkLocation;
        }
        if (networkLocation == null) {
            Log.d(TAG, "No Network Location available");
            return gpslocation;
        }

        //a locationupdate is considered 'old' if its older than the configured update interval. this means, we didn't get a
        //update from this provider since the last check
        long old = System.currentTimeMillis() - 1800000; //That's 30 minutes
        boolean gpsIsOld = (gpslocation.getTime() < old);
        boolean networkIsOld = (networkLocation.getTime() < old);

        //gps is current and available, gps is better than network
        if (!gpsIsOld) {
            Log.d(TAG, "Returning current GPS Location");
            return gpslocation;
        }

        //gps is old, we can't trust it. use network location
        if (!networkIsOld) {
            Log.d(TAG, "GPS is old, Network is current, returning network");
            return networkLocation;
        }

        // both are old return the newer of those two
        if (gpslocation.getTime() > networkLocation.getTime()) {
            Log.d(TAG, "Both are old, returning gps(newer)");
            return gpslocation;
        } else {
            Log.d(TAG, "Both are old, returning network(newer)");
            return networkLocation;
        }
    }

    /**
     * get the last known location from a specific provider (network/gps)
     */
    private Location getLocationByProvider(String provider) {
        Location location = null;

        LocationManager locationManager = (LocationManager) ctxt
                .getSystemService(Context.LOCATION_SERVICE);

        try {
            if (locationManager.isProviderEnabled(provider)) {

                location = locationManager.getLastKnownLocation(provider);

            }
        } catch (IllegalArgumentException e) {
            Log.d(TAG, "Cannot access Provider " + provider);
        }
        return location;
    }
}
