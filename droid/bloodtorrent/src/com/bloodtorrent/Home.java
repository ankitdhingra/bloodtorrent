package com.bloodtorrent;

import com.calatrava.CalatravaPage;
import com.calatrava.shell.WebViewActivity;

import java.util.Arrays;
import java.util.List;

@CalatravaPage(name = "home")
public class Home extends WebViewActivity
{
  @Override
  protected String getPageName() {
    return "home";
  }

  @Override
  protected List<String> getEvents() {
    return Arrays.asList("viewDonationListBtn", "addDonationRequestBtn");
  }

  @Override
  protected List<String> getFields() {
    return Arrays.asList();
  }
}
