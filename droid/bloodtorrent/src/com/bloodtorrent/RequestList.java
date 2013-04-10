package com.bloodtorrent;

import com.calatrava.CalatravaPage;
import com.calatrava.shell.WebViewActivity;

import java.util.Arrays;
import java.util.List;

@CalatravaPage(name = "requestList")
public class RequestList extends WebViewActivity
{
  @Override
  protected String getPageName() {
    return "requestList";
  }

  @Override
  protected List<String> getEvents() {
    return Arrays.asList("goHome", "donationRequest");
  }

  @Override
  protected List<String> getFields() {
    return Arrays.asList();
  }
}
