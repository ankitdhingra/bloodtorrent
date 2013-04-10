package com.bloodtorrent;

import com.calatrava.CalatravaPage;
import com.calatrava.shell.WebViewActivity;

import java.util.Arrays;
import java.util.List;

@CalatravaPage(name = "requestDetail")
public class RequestDetail extends WebViewActivity
{
  @Override
  protected String getPageName() {
    return "requestDetail";
  }

  @Override
  protected List<String> getEvents() {
    return Arrays.asList();
  }

  @Override
  protected List<String> getFields() {
    return Arrays.asList();
  }
}
