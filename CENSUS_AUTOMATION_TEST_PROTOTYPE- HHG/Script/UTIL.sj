/********************************************************************************
TAG               : #findObject, #querySelector 
Function Name     : isUndefined(parent,query)
Description       : function to abstract all the weblements from x-search search panel
Date              : 10/12/2017
TE                : Bipin.R
Parameters        : isUndefined(Aliases.PAGE,"div.settings.doc-menubar");
Pre condition     : Parent has to be available
Objective         : return either an object or null
********************************************************************************/ 
function unitTestisUndefined(){
   // var obj = isUndefined(Aliases.PAGE,"div.settings.doc-menubar");
   //Aliases.MAIN_CNTR_PANEL_OFFICE_ACTION;
   var textNode = isUndefined(Aliases.MAIN_CNTR_PANEL_03_FORM_PARAGRAPHS,'div.info');
   //Log.Message(Aliases.MAIN_CNTR_PANEL_OFFICE_ACTION.GetUnderlyingObject().MappedName)
   
 }

function isUndefined(parent,query){
    if(!parent.Exists){
         Log.Error("Parent Object is not not available",'',500,attr.err,Sys.Desktop); 
      return undefined;
     }
    if(parent.querySelector(query)){
       var obj = parent.querySelector(query);
       return obj; 
    }else{
      Log.Error("Object could not be found using :\""+query+"\" query",'',500,attr.err,Sys.Desktop);
      return undefined;
    }
}
/********************************************************************************
TAG               : #findObject, #querySelector 
Function Name     : unitTestisUndefined(parent,query)
Description       : function to abstract all the weblements from x-search search panel
Date              : 10/12/2017
TE                : Bipin.R
Parameters        : isUndefined(Aliases.PAGE,"div.settings.doc-menubar");
Pre condition     : Parent has to be available
Objective         : return either an object or null
********************************************************************************/ 

function isUndefinedWithXpath(parent , xpath){
try{
if(!parent){
  throw "Parent of the "+xpath + " is not available";
}
      var element = parent.FindChildByXPath(xpath,true);
            if(element){
               return element;
            }else{
              throw "Could not find "+ keys;            
            }
    }catch(e){
      Log.Message("Object could not be found using :\""+xpath+"\" XPATH",'',500,attr.err,Sys.Desktop);
      return null;
    }          
}
/********************************************************************************
TAG               : #findObject, #querySelector, #objectExists #isExists
Function Name     : isExist(parent,query)
Description       : function to abstract all the weblements from x-search search panel
Date              : 10/27/2017
TE                : Bipin.R
Parameters        : isExists(Aliases.PAGE,"div.settings.doc-menubar");
Pre condition     : Parent has to be available
Objective         : return either an object or null
********************************************************************************/ 
function isExist(parent,query){
    if(parent.querySelector(query)){
       var obj = parent.querySelector(query);
       return obj; 
    }else{
      Log.Message("Object could not be found using :\""+query+"\" query",'',500,attr.act,Sys.Desktop);
      return null;
    }
}




/********************************************************************
Function Name 				:_util_setText(obj,value)
Description						:Function will enter the text into the TextBox
Parameters						:obj,value
Date                  :  
Author                :Bipin.R
xample                :_util_setText(Aliases.VIEW_INTERNAL_NOTE.INTERNAL_NOTE_FORM_SUBJECT_TXTBOX,'Mentor')
*********************************************************************/
function _util_setText(obj,value) {
    try {
        Log.AppendFolder("**** Entering Text: \""+value+ "\" in TextBox **","",300,attr.sub);
             obj.Click();
             obj.Keys('^a'+'[Del]'+value);
        Log.PopLogFolder(); 
    }
    catch(e) {
        Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
        Log.PopLogFolder();
    }
}



/********************************************************************************
        Function Name     : attr
        Description       : function to color scenarios, features, messages...
        Date              : 08/19/2016
        Author            : Bipin.R
        Param             : N/A
        Example           : 
        Return            : 
        Log.AppendFolder("Sending Combined Examiner's Amendment and Priority Action using User logged in :-Curtis",'',100,attr.par)
        Log.AppendFolder("TEST",'',100,attr.sub)
        Log.Message("TEST",'',100,attr.act)
        Log.Message("TEST",'',100,attr.ver)
        Log.Message("TEST",'',100,attr.val)
//par//sub//err//val//ver//act

/********************************************************************************/ 

function unittestLog(){

Log.AppendFolder("Step 1");
  Log.Message("My Name is Slim",'Slim in not slim',500,attr.ver,Sys.Desktop);
  Log.Message("My Name is Slim",'Slim in not slim',100,attr.val,Sys.Desktop);
  Log.Message("My Name is Slim",'Slim in not slim',200,attr.err,Sys.Desktop);
  Log.Message("My Name is Slim",'Slim in not slim',300,attr.act,Sys.Desktop);
  Log.Message("My Name is Slim",'Slim in not slim',400,attr.sub,Sys.Desktop);
  Log.Message("My Name is Slim",'Slim in not slim',500,attr.par,Sys.Desktop);
Log.PopLogFolder();



}


var attr = (function() {
   try {
        Attr = Log.CreateNewAttributes();  
        Attr.Bold = true;
        var attrObj = {
            par            : color('Navy'), // for parent/ scenerio 
            sub            : color('Blue'), // for Sub folder/ features
            act            : color('Teal'), // for action
            ver            : color('Green'),// for verification
            val            : color('Lime'), // for validation
            err            : color('Red'),  // for error
            neg            : color('Olive') // for -Ve test
        }
         function color(cl) {
                var Attr = Log.CreateNewAttributes();  
                    if (cl == 'Navy') {
                      Attr.FontColor = clNavy;
                      Attr.Bold = true;
                     }
                     else if (cl == 'Teal') {
                      //Attr.FontColor = clTeal;
                      Attr.Bold = true;
                     // Attr.Italic = true;
                     }
                    else if (cl == 'Blue') {
                       Attr.FontColor = clBlue;
                      }
                    else if (cl == 'Green') {
                      Attr.FontColor = clGreen;
                      Attr.Bold = true;
                     }
                    else if (cl == 'Lime') {
                      Attr.FontColor = clGreen;
                      Attr.BackColor = clMoneyGreen;
                      Attr.Bold = true; 
                      }
                    else if (cl == 'Red') {
                      Attr.FontColor = clRed;
                      Attr.Bold = true;
                     }
                     else if (cl == 'Olive') {
                      Attr.FontColor = clOlive;
                      Attr.Bold = true;
                     }
                    return Attr;
                  };
            return attrObj;
       }
       catch(e){
            Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
       }
})();



/********************************************************************************
        Function Name     : method
        Description       : function to work with methdos on web elements - its action type
        Date              : 01/30/2018
        Author            : Bipin.R
        Param             : N/A
        Example           : 
/********************************************************************************/ 
function unitTest_method(){
  method(Aliases.BROWSER.PC_PAGE, 'test')
}
function method(object, value){
   try{
        Log.AppendFolder("Entering or selecting : "+ value);
         if(!object){
          throw "Object is not available on screen";
         }
         if(object.clientHeight<1){
             throw "Object is not displayed on screen";
           }
                   switch ( aqString.ToLower(object.ObjectType ))
                   {
                     case 'select':
                          object.ClickItem(value);
                       break;
                     case 'button':
                          object.Click();
                       break;
                     case 'textbox':
                          _util_setText(object,value);  
                       break;   
                     case 'input':
                          _util_setText(object,value);     
                       break;  
                     case 'searchbox':
                          _util_setText(object,value);  
                       break;  
                     case 'textarea':
                          _util_setText(object,value);  
                       break;
                   }
        Log.PopLogFolder();        
   }catch(e){
         Log.Error(e);
      Log.PopLogFolder(); 
     return e;
   }
   
}

/********************************************************************************
Function Name     : findByText
Description       : method to find element by text
Date              : 02/05/2018
TE                : Bipin.R
Parameters        : parenemtElementObj, innerText or text for the element
 
*********************************************************************************/

function unitTest_findByText(){
   findByText(Aliases.BROWSER.PC_PAGE, 'Application details');
}

function findByText(parent, txt){
  try{
//       if(!parent){
//         throw "Parent element for "+txt " is not available";
//        }
       Log.AppendFolder("Locating \""+ txt + " \" web element",'',500,attr.act);
              var o =  parent.FindChildByXPath("//*[text() =\'"+txt+"\']");
                 if(o==undefined){
                    Log.Warning("Web Element \""+txt+"\" could not be located",'',400,attr.err,Sys.Desktop);
                 }   
       Log.PopLogFolder();    
       return o; 
     }catch(e){
        Log.Error(e);
         return e;
     }
}


/********************************************************************************
Function Name     : getTestDataonJSONFormatt
Description       : convert the excel sheet data to JSON
Date              : 02/05/2018
TE                : Bipin.R
Parameters        : 
Pre condition     : 
Objective         :
Example           : 
*/
function unitTest_getTestDataonJSONFormatt(){
    var fileName = "eMOD_WebADS_TestData.xlsx";
    var sheetName = 'invalidSearchData';//'test'//
      j =   getTestDataonJSONFormatt(fileName,sheetName);
      for(var index in j){
       Log.Message(index +" : " +j[index]);
      }
 }

//*********************************************************************************/
function getTestDataonJSONFormatt(fileName,sheetName){
  try{
        Log.AppendFolder("Get TestData on JSON Formatt",'',500,attr.par);
              var jobj = {};
              Log.Message("Test Data path : "+Project.Path+"TEST DATA\\"+fileName);
              DDT.ExcelDriver(Project.Path+"TEST DATA\\"+fileName,sheetName,true);
                  Log.AppendFolder("Creating a JSON data from "+ Project.Path+"TEST DATA\\"+fileName + "Sheet Name: "+ sheetName,'',500,attr.par);
                    while (! DDT.CurrentDriver.EOF()) { 
                            for(var i=0 ; i<DDT.CurrentDriver.ColumnCount ;i++){
                              Log.Message(DDT.CurrentDriver.ColumnName(i)+" : "+DDT.CurrentDriver.Value(i)+',');
                              jobj[DDT.CurrentDriver.ColumnName(i)]  = DDT.CurrentDriver.Value(i);
                            }
                      DDT.CurrentDriver.Next(); 
                    }
                  Log.PopLogFolder();  
               DDT.CloseDriver(DDT.CurrentDriver.Name); 
        Log.PopLogFolder();   
        return   jobj;
     } catch(e) {
      Log.Error("Error \""+ e + "\" Error Description "+ e.description);
     }
}


/********************************************************************************
        Function Name     : attr
        Description       : function to color scenarios, features, messages...
        Date              : 08/19/2016
        Author            : Bipin.R
        Param             : N/A
        Example           : Log.AppendFolder("Sending Combined Examiner's Amendment and Priority Action using User logged in :-Curtis",'',100,attr.par)
                            Log.AppendFolder("TEST",'',100,attr.sub)
                            Log.Message("TEST",'',100,attr.act)
                            Log.Message("TEST",'',100,attr.ver)
                            Log.Message("TEST",'',100,attr.val) 
//par//sub//err//val//ver//act
/********************************************************************************/ 
var attr = (function() {
   try {
        Attr = Log.CreateNewAttributes();  
        Attr.Bold = true;
        var attrObj = {
            par            : color('Navy'), // for parent/ scenerio 
            sub            : color('Blue'), // for Sub folder/ features
            act            : color('Teal'), // for action
            ver            : color('Green'),// for verification
            val            : color('Lime'), // for validation
            err            : color('Red'),  // for error
            neg            : color('Olive') // for -Ve test
        }
         function color(cl) {
                var Attr = Log.CreateNewAttributes();  
                    if (cl == 'Navy') {
                      Attr.FontColor = clNavy;
                      Attr.Bold = true;
                     }
                     else if (cl == 'Teal') {
                      //Attr.FontColor = clTeal;
                      Attr.Bold = true;
                     // Attr.Italic = true;
                     }
                    else if (cl == 'Blue') {
                       Attr.FontColor = clBlue;
                      }
                    else if (cl == 'Green') {
                      Attr.FontColor = clGreen;
                      Attr.Bold = true;
                     }
                    else if (cl == 'Lime') {
                      Attr.FontColor = clGreen;
                      Attr.BackColor = clMoneyGreen;
                      Attr.Bold = true; 
                      }
                    else if (cl == 'Red') {
                      Attr.FontColor = clRed;
                      Attr.Bold = true;
                     }
                     else if (cl == 'Olive') {
                      Attr.FontColor = clOlive;
                      Attr.Bold = true;
                     }
                    return Attr;
                  };
            return attrObj;
       }
       catch(e){
            Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
       }
})();

/********************************************************************************
Function Name     : exc_LogFunctionExceptionAndEscalate
Description       : Logs the error and re-throws the error object.
Author            : HHG
Parameters        : strFunction, errObject
Example           : exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
********************************************************************************/
function exc_LogFunctionExceptionAndEscalate( strFunction, errObject )
{
    try  {
        Log.Warning( "Error '" + errObject.name + "' found in function " + strFunction + "(): " + errObject.message);
      } catch ( err )  {
         // If error occured, ignore it to prevent potential infinite error loop.
     } finally  {
        // Pass the error object back up.
        Log.PopLogFolder();
        throw errObject;
    }
}    

//Get todays system date and convert to string
 function getTodaysDate(){
    var CurrentDate = aqDateTime.Today();
    // Convert the date/time value to a string and post it to the log
    Today = aqConvert.DateTimeToStr(CurrentDate);
    Log.Message("Today is " + Today);
    return Today;
 }
 
 
function trimString(strg){
    try {
        var srchDate;
        var mystrg = strg.toString();
        srchDate = Utilities.TrimLeft(mystrg);
        srchDate = Utilities.TrimRight(mystrg); 
        return srchDate;   
       } catch(err) {
        exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
  }          
}


//Latest  Version of Close Excel - But during repeated runs sometime we notice Quit/Terminate is not terminating well.
function closeExcelAll(){
  try {
      var gl_ProcsName = "ProcessName";
      var gl_recvObjExcel = "EXCEL";
      var prcsNme = Sys.Find(gl_ProcsName, gl_recvObjExcel);
      while (prcsNme.Exists) {
            var prcsNmeId = prcsNme.ProcessID;
            //prcsNme.Close();

            var WshShell = new ActiveXObject("WScript.Shell");
            var oExec = WshShell.Exec("taskkill /f /t /pid " + prcsNmeId);        

            var isClosed = prcsNme.WaitProperty("Exists", false);
            if (! isClosed)     {
                  prcsNme.Terminate();
              }
            prcsNme = Sys.Find(gl_ProcsName, gl_recvObjExcel);
      }
   }catch(err){
    exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
    Log.Error("Error While Closing Excel:" + e.description +" " + err.message);
    return Runner.Stop(true);
  } 
  Log.Checkpoint("Existing Excels is closed to start new exution." )
}




//function to clean Cash and cookies -- 
 function ClearCache()
    // function to clear cache 
    {
           try
           {
                 WshShell = Sys.OleObject("WScript.Shell")
                 //Delay(5000)
                 WshShell.Run("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8");
                 Log.Checkpoint("Deleted Cache")
                 return
                 true;
           } catch(err)   {
                exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
                Log.Message("error deleting cache")
                return false;
           } 
    }

function ClearCookies()
// function to clear cookies 
 {
          try
          {
             WshShell = Sys.OleObject("WScript.Shell")
             WshShell.Run("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2");
             Log.Checkpoint("Deleted Cookies")
             return
             true;
          }
    catch(err)
      {
      exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
      Log.Message("error in deleting Cookies")
      return false;
      } 

 }

