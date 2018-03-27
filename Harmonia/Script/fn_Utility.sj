//USEUNIT libIncludes
 //Get todays system date and convert to string
 function getTodaysDate()
 {
    var CurrentDate = aqDateTime.Today();
    // Convert the date/time value to a string and post it to the log
    Today = aqConvert.DateTimeToStr(CurrentDate);
    Log.Message("Today is " + Today);
    return Today;
 }
 
 
function trimString(strg)
{
    try
    {
        var srchDate;
        var mystrg = strg.toString();
        srchDate = Utilities.TrimLeft(mystrg);
        srchDate = Utilities.TrimRight(mystrg); 
        return srchDate;   
    }
   
 catch(err)
 
  {
  exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
  }          
}




//Latest  Version of Close Excel - But during repeated runs sometime we notice Quit/Terminate is not terminating well.
function closeExcelAll()
{
  try
  {
      var gl_ProcsName = "ProcessName";
      var gl_recvObjExcel = "EXCEL";
      var prcsNme = Sys.Find(gl_ProcsName, gl_recvObjExcel);
      while (prcsNme.Exists)
      {
            var prcsNmeId = prcsNme.ProcessID;
            //prcsNme.Close();

            var WshShell = new ActiveXObject("WScript.Shell");
            var oExec = WshShell.Exec("taskkill /f /t /pid " + prcsNmeId);        

            var isClosed = prcsNme.WaitProperty("Exists", false);
            if (! isClosed)
              {
                  prcsNme.Terminate();
              }
            prcsNme = Sys.Find(gl_ProcsName, gl_recvObjExcel);
      }
  }
 
 catch(err)
 
  {
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
           }

    catch(err)
 
     {
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

/********************************************************************************
Function Name     :getCaseFromDB(caseSource)
Description       :Function to return a query result from DB  
Date              :12/11/2015  
Author            :Nebyu 
Parameters        :caseSource 
Example           :
********************************************************************************/
function getCaseFromDB(caseSource) {
    try { 
      arr_Return = glob_oracleSQL(caseSource);
      dataRetrieved = arr_Return[0].split('|');
      //Use this variable throughout the scenario
      return trimString(dataRetrieved[0]);
    }
    catch(err) 
    {
      exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err);
    } 
}
    
function glob_oracleSQL(SQLQuery)
{ 
try
{
     var sql,rs,rowCount
    // Create a new Connection object
            oracleConnection = ADO.CreateADOConnection(); 
            strConnection = ProjectSuite.Variables.Db_CON_PVT +";User ID="+ ProjectSuite.Variables.DB_USER + ";Password=" + aqConvert.VarToStr(ProjectSuite.Variables.DB_PWD) + ";"
            //var DbCon ="(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=pvt-tmng-db-1.etc.uspto.gov)(PORT=1602)))(CONNECT_DATA=(SERVER=pvt-tmng-db-1)(SERVICE_NAME=TRMPVT)))"
           // "Provider=OraOLEDB.Oracle;Data Source=" + DbCon +";User ID=" + strUserID + ";Password=" + strPassword + ";"

            oracleConnection.LoginPrompt = false;
            oracleConnection.ConnectionString = strConnection;
            oracleConnection.LoginPrompt=false;
    
         //Close the Existing Connections if already Open
           if (oracleConnection.state == 1)
                  {oracleConnection.close();}
           oracleConnection.Open() ;
           Log.Checkpoint("Connection to Database is Successfull");
        
          //Execute the Sql
            var SQLQuery= SQLQuery.toString();               
            var recordSet       = oracleConnection.Execute_(eval(SQLQuery));
            (recordSet.Fields(0).Value != null)? Log.CheckPoint("SQL query correctly executed "): Log.Error("The Query excuted with an error")
         
          //Loop till End of Record, get all the Rows and columns using count.
            var rowCount=recordSet.RecordCount;
            Log.Message("SQL Execution Row Count = " + rowCount);
            var arr_Return = [];
          if (rowCount > 0 )
           {
                //Get The First Record
                recordSet.MoveFirst();
                nFldCount =  recordSet.Fields.count  ;
                //Log.Message(nFldCount + "|" +rowCount); //Debug for later if needed - by individual testers  //Log.Message(recordSet.Fields(0).Value);
                if (rowCount >= 100) //Limit the Row Count to 100 Max. For testing we do not need more than that as far as estimated/Subject to change
                {
                  rowCount = 100;
                }
                for(n=0;n<rowCount ;n++)
                {
                        var rowValue = "";
                        for(i=0 ; i< nFldCount; i++)
                        {
                              if(recordSet.Fields(i).Value == null)
                              {
                                    arr_Return[n][i] = new Date();
                              }
                              else
                              {
                                    rowValue = rowValue + aqString.Trim(recordSet.Fields(i).Value) +"|"; //Delimit all values and send it back
                              }     
                        }
                        arr_Return[n] = rowValue; //Concatenate the Values of Arrays
                        recordSet.MoveNext();                         //Move the Next Record
                  }
                  Log.Message("Total Retreived Values for the SQL::" +arr_Return);
                  oracleConnection.close();
                  //return ["Yes" , arr_Return];
                  return arr_Return;
             }
            else
            {
                oracleConnection.close(); 
                return ["No"]; 
            }
  }
  catch(err)
 
     {
      exc_LogFunctionExceptionAndEscalate( exc_GetFunctionName( arguments ), err );
      oracleConnection.close();
        Log.Error(" Error while Test Step of SQL Execution :: " +  e.description + "" + e.name + "|" ); 
      return Runner.Stop(true);
      
      } 
  
   
}
