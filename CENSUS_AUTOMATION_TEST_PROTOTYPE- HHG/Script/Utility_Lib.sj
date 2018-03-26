
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

/********************************************************************
Function Name 				: _util_setText(obj,value)
Description						: Function will enter the text into the TextBox
Parameters						: obj,value
Author                : Bipin.R
xample                : _util_setText(Aliases.VIEW_INTERNAL_NOTE.INTERNAL_NOTE_FORM_SUBJECT_TXTBOX,'Mentor')
*********************************************************************/
function _util_setText(obj,value) {
    try {
        //StepIn_on(" ** Entering Text : \""+value+ "\" on TextBox **", clBlue);    
        Log.AppendFolder(" ** Entering Text: \""+value+ "\" in TextBox **","",300,attr.sub);
             obj.Click();
             //obj.Keys('^a'+'[Del]'+value);
             obj.Keys('^a');
             obj.Keys('[Del]');
             obj.Keys(value); 
        Log.PopLogFolder(); 
    }
    catch(e) {
        Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
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
