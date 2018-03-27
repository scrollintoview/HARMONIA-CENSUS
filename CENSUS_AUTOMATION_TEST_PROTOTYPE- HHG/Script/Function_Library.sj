﻿//USEUNIT UTIL


/********************************************************************************
Function Name     :ListBrowsers()
Description       :Function to display the list of browsers available in the machine
Author            :BIPIN.R  
Parameters        :N/A
Example           :ListBrowsers()
********************************************************************************/
function ListBrowsers() {
    try {
        //StepIn_on("Accesing Testing machine browsers List :-" + "", clNavy);
        Log.AppendFolder("Accessing Testing machine browsers List: ","",300,attr.par);
        var browser;
        for (var i = 0; i < Browsers.Count; i++) {
            browser = Browsers.Item(i);
            Log.Message("  Browser " + aqConvert.IntToStr(i) + ": " + browser.Description + " Installed in this testing machine");
        }
        Log.PopLogFolder();
       } catch (err) {
        exc_LogFunctionExceptionAndEscalate(exc_GetFunctionName(arguments), err);
    }
}

/********************************************************************************
Function Name     :browserVersionTest
Description       :Function to verify version of browsers used
Author            :BIPIN.R  
Parameters        :btVersion
Example           :browserVersionTest("chrome42")
********************************************************************************/
function browserVersionTest(btVersion) {
    try {
        var regex = /\d{2}/;
        var test = regex.test(btVersion);
        Log.Message(" REG EX RESULTED: " + btVersion);
        if (test) {
            Log.Checkpoint(" TEST STEP PASS: " + btVersion + " Format Validated ");
            var exec = regex.exec(btVersion);
            Log.Message(exec);
            switch (parseInt(exec)) {
                case 37:
                    Aliases.browser.BrowserWindow(0).Keys("[Tab][Tab][Enter][Tab][Enter]");
                    break;
                case 35:
                    Aliases.browser.BrowserWindow(0).Keys("[Tab][Enter]");
                    break;
                case 32:
                    Aliases.browser.BrowserWindow(0).Keys("[Tab][Enter]");
                    break;
            }
        } else {
            Log.Error(" Cannot validate the Browser Version");
        }
    } catch (e) {
        Log.Error("***** TRY CATCH*** ERROR  from BrowserVersionTest " + e.name + "  " + e.message + " " + e.description);
    }
}
/********************************************************************************
Function Name     :launchApplication
Description       :Function to launch the TMNGI Application
Author            :BIPIN.R  
Parameters        :url,bwr(getBrowserContent("browser"),getBrowserContent("url"))
Example           :launchApplication("chrome","https://pvt-tmng-ui.etc.uspto.gov/tmng/internal/index.html");
********************************************************************************/ 
function launchBrowser() {
    try {
    var _bwr = getBrowserContent('browser');
    //Project.Variables.BROWSER;
    var _url = getBrowserContent('URL')//Project.Variables.URL;
          Log.AppendFolder("Launching Application : \""+ _url+"\"", "",100,attr.sub);  
          closeBrowser();
              Browsers.Item(_bwr).Run(_url);
//              if(Aliases.BROWSER.CERTIFICATE_ERROR_PAGE.OVERIDE_LINK.WaitProperty("Exists",true,3000)){
//                 Aliases.BROWSER.CERTIFICATE_ERROR_PAGE.OVERIDE_LINK.Click();
//              }
              Sys.Browser(_bwr).Page("*").Wait();
              //Maximize the browser
              Sys.Browser(_bwr).BrowserWindow(0).Maximize();
              Sys.Browser(_bwr).Refresh();
              //This line of code verify TMNGI application is correctly launched  
              if (Aliases.BROWSER.PAGE.Exists) {
                  Log.Event("Browser Invoked",'',500,attr.ver,Sys.Desktop);
//                    if(Aliases.BROWSER.PAGE.LOGIN_TXT.WaitProperty("Exists",true,30000)){
//                       Log.Checkpoint("User Landed to Login Page",'',500,attr.ver,Sys.Desktop);
//                    }else{
//                      Log.Error("User Did not Land to Login Page",'',500,attr.err,Sys.Desktop);
//                       Runner.Stop();
//                    }
              } else {
                  Log.Error("Browser did not Invoke",'',500,attr.err,Sys.Desktop);
                  Runner.Stop();
              }
          Log.PopLogFolder();
    } catch (e) {    
          Log.Error("***** TRY CATCH*** ERROR  from BrowserVersionTest " + e.name + "  " + e.message + " " + e.description);;
    }
}



function closeBrowser(){
  try{
       if (Sys.WaitBrowser().Exists) {
                  Sys.Browser().Close();
                  Log.Message("Closing all the Browser instances before running Test script");
              }

   }catch(e){
    Log.Error("***** TRY CATCH*** ERROR  from BrowserVersionTest " + e.name + "  " + e.message + " " + e.description);
  }
}


/********************************************************************************
Function Name     :login
Description       :Function to login to TMNGI 
Return            :false if you cannot log in for multiple reasons  
Parameters        :(userAlias,userName,passwordAlias,passWord,LoginbtnAlias)
Example           :login(Aliases.LOGIN_USERNAME_TXT,EmployeeNo,Aliases.LOGIN_PASSWORD_TXT,Project.Variables.empPwd,Aliases.LOGIN_BTN)
********************************************************************************/
function login(userAlias, userName, passwordAlias, passWord, LoginbtnAlias) {
    try {
        //Below generic code verify the user name object and enter the username box  
        userAlias.WaitProperty("Exists", true, 60000);
        if ((userAlias.Width > 0) || (passwordAlias.Width > 0)) {
            Log.Checkpoint("User Name and Password text boxes are visible for login", "", pmHighest, attr.ver, Sys.Desktop);
             if(aqString.Find(Aliases.BROWSER.PAGE.LOGIN_FORM.SELECT_USER.wItemList,userName,0,false)==-1){
              Log.Error("The User name is not found in the Dropdown",Aliases.BROWSER.PAGE.LOGIN_FORM.SELECT_USER.wItemList,500,attr.err,Sys.Desktop);
              return false;
             }
             userAlias.ClickItem(userName);
            _util_setText(passwordAlias,passWord);
            LoginbtnAlias.Click();
           Aliases.BROWSER.PAGE.Wait(10000);
           if (Aliases.BROWSER.PAGE.Exists) {
              if (Aliases.BROWSER.PAGE.LOGIN_FORM.PasswordError.WaitProperty("Exists",true,3000)) {
                Log.Error("Could not Log in to the System", "", pmHighest, null, Sys.Desktop);
                return false;
              } 
            }                     
        } else {
            Log.Error(" UserName or password textbox is not visible - Test Excution stopped", "", pmHigher, FColor(clRed));
            return false;
            Runner.Stop(); ///we should stop the runner if we can't login.
        }
    } catch (err)    {
        exc_LogFunctionExceptionAndEscalate(exc_GetFunctionName(arguments), err);
    }
} 


function navigateToMyAccountPage(){
    try {   
       Log.AppendFolder("Navigating to Account snapshot Page",'',500,attr.sub);
           var PROTOTYPE_PAGE = Aliases.BROWSER.PAGE;
           if(Aliases.BROWSER.PAGE.WaitProperty("Exists",true,3000)){
            var TEST_TAB =  PROTOTYPE_PAGE.TEST_TAB;
                TEST_TAB.Click();
                if(PROTOTYPE_PAGE.MY_AC_TEXT_NODE.WaitProperty("Exists",true,5000)){
                 Log.Checkpoint("User Landed to Account snapshot page after clicking on the Tab",'',500,attr.ver,Sys.Desktop);
                }else{
                 Log.Error("Error: User did not land to Account Snapshot page",'',500,attr.err,Sys.Desktop);
                 Log.PopLogFolder();     
                 return false;
                }
            }else{
              Log.Error("Error: Account Snapshot page is not available",'',500,attr.err,Sys.Desktop);
              Log.PopLogFolder();     
              return true;
            }
        Log.PopLogFolder();       
        } catch (err)    {
        exc_LogFunctionExceptionAndEscalate(exc_GetFunctionName(arguments), err);
    }
}

function GeneralEvents_OnLogWarning(Sender, LogParams)
{
  if(LogParams.MessageText = "The mapped item has the Extended Find attribute enabled."){
     LogParams.locked = true;
  }
}


/***********************************************************************************************************************
fn Name            : getEnvVariable 
Parameters         : n/a
Example            : var config = getEnvVariable();
********************************************************************************/
function getEnvVariable(){
try{
       var autoconfig  ;
       var jPath = ProjectSuite.Path+"autolibenv.JSON";
       var data  = aqFile.ReadWholeTextFile(jPath, aqFile.ctANSI);
       var autoconfig = JSON.parse(data);
       return autoconfig;
   }catch(e){
     Log.Error("Try Catch Error : "+ e.Name);
   }
}


/***********************************************************************************************************************
Author            :Common Library 
Parameters        :keyVal 
Example           :getBrowserContent("browser")
********************************************************************************/
function unitTest_getBrowserContent(){
    var url = getBrowserContent('URL');
        Log.Message(url);
        browser = getBrowserContent('browser');
        Log.Message(browser);
        // browser = getBrowserContent('URL');
  }
function getBrowserContent(keyVal){
try{
    var sPath = ProjectSuite.Path+"\setURL.txt";
          if(keyVal=='browser'){
            var browser   = getValueByKey(sPath,keyVal).replace(" ","");
            return browser;
          }
          else if(keyVal=='URL'){
            var browser   = getValueByKey(sPath,keyVal).replace(" ","");
            return browser;
          }
          var env   = getValueByKey(sPath,'env').replace(" ","");
          var config = getEnvVariable();
          return config[env][keyVal];
   }catch(e){
     Log.Error("Try catch error on getBrowserContent -- "+ e.Message);
   }       
}

  
/********************************************************************************
Function Name     :getValueByKey(sPath,key)
Description       :Get value from text file by key
Date              :  
Author            :Common Library 
Parameters        : sPath,key
Example           :getValueByKey(ProjectSuite.Path+"\setURL.txt","browser")
********************************************************************************/
function getValueByKey(sPath,key)
{
    try
    {
      if (key != "") {
          var s,keyStr,valRetn;
          // Opens the specified file for reading
          var myFile = aqFile.OpenTextFile(sPath, aqFile.faRead, aqFile.ctANSI);
          // Reads text lines from the file and posts them to the test log 
          while(!myFile.IsEndOfFile())
          {
              s = myFile.ReadLine();
              keyStr = s.split("=");
              if (key == keyStr[0]) {
          	      valRetn = keyStr[1];
          	      break;
              }
          }
          myFile.Close(); //Closes the file
          return valRetn;
      }
      else 
          return "";
    }   
    catch(err)
    {
      exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err);
    }  
} 


/***********************************************************************************************************************    
Function Name     : invokeIntBrowser(URL)
Description       : Navigate to any URL
Date              : 07/21/2017 
Author            : Common Library 
Parameters        : URL
Example           : invokeIntBrowser(getBrowserContent("urlInternal"));
***********************************************************************************************************************/ 
function unitTest_invokeIntBrowser(){
   invokeIntBrowser(getBrowserContent("urlInternal"));
}  
function invokeIntBrowser(URL)
  {
      try
      {  
      Log.AppendFolder("Invoke Browser to navigate to "+ URL);
              if (Sys.WaitBrowser().Exists) 
              {
                 Sys.Browser().Close();
                  //Delay(5000, "Please wait for 5 seconds")
                  Log.Message("Closing all the Browser instances to Run Test Script");
              }
              var BrowserItem= getBrowserContent("browser");
           
              Browsers.Item(BrowserItem).Run(URL);
                Aliases.Browser.BrowserWindow(0).Maximize();
              //Identifying Chrome Browser Version and working with the Certification- 37.XX 
              //and the pre-version has a different way of processing through Certificate
//              if (Aliases.browser.ObjectIdentifier== "chrome" )
//                 {  
//                   Log.Event("Processing through Certification");
//                   Log.Message("Chrome Browser Version"+Aliases.Browser.FileVersionInfo);
//                   BrowserVersionTest(Aliases.Browser.FileVersionInfo);
//                   page.Wait();
//                 }
//                else if (Aliases.browser.ObjectIdentifier=="iexplore") 
//                 {
//                    var continueLink = page.FindChild(["contentText","ObjectType"],["Continue to this website (not recommended).","Link"],10);
//                    continueLink.Click();
//                     page.Wait();
//                 } 
      }
      catch (e)
      {
         Log.Error("***** TRY CATCH*** ERROR "+ e.name+ " Error Message "+e.message )  
          Runner.Stop(true);
      }  
    Log.PopLogFolder();        
 } 