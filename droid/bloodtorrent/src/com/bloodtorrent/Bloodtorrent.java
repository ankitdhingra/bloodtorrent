package com.bloodtorrent;

import android.app.Activity;
import android.os.Bundle;

import com.calatrava.bridge.Launcher;

public class Bloodtorrent extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        Launcher.launchKernel("com.bloodtorrent", this, getApplication(), new Runnable() {
          public void run() {
            Launcher.launchFlow("example.converter.start");
          }
        });
    }
}
