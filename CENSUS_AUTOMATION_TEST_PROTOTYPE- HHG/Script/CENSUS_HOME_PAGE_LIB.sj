//USEUNIT UTIL

function closeConnectedPanel(){
  if(Aliases.BROWSER.PAGE.STAY_CONNECTED_PANEL.CLOSE_BTN.WaitProperty("Exists",true,3000)){
     Log.AppendFolder("Closing Stay connected panel",'',500,attr.act);
        Aliases.BROWSER.PAGE.STAY_CONNECTED_PANEL.CLOSE_BTN.Click();
      Log.PopLogFolder();  
  }else{
   Log.Message("\"Stay connected\" panel is not available");
  }
  
  
  //CLOSE_BTN
}