//USEUNIT UTIL

// Abstraction of tax Return Status
// Abstraction of Tax Record Summary
function unitTestgetMyAccout(){
  var summery= getTaxRecordSummary();
  Log.Message(summery.TotalExceptions);

}
//function to get values in the form of JSON from account snapshot TaxRecordSummary
function getTaxRecordSummary(){
     try{
          Log.AppendFolder("Get Tax Record values from Account snapshot page",'',500,attr.sub);
           var PAGE, RETURN_STATUS_PANE, taxReturnLatestObj, taxReturnHistoryObj, taxRecordSummeryObj,TRANSCRIPT_INFO_PANEL,BALANCE_SUMMARY;
               PAGE= Aliases.BROWSER.PAGE;
               RETURN_STATUS_PANE= PAGE.RETURN_STATUS_PANEL;
               TRANSCRIPT_INFO_PANEL = PAGE.TRANSCRIPT_INFO_PANEL;
               BALANCE_SUMMARY= PAGE.BALANCE_SUMMARY
               PAGE.WaitProperty("Exists",true,2000);
              if( PAGE.TAX_RECORD_SUMMARY_HEADER.Exists){
                  Log.Checkpoint("Tax record Summary Header verified ",'',500,attr.ver, PAGE.TAX_RETURN_TITLE);
                  taxRecordSummeryObj = {
                     TotalExceptions: returnValue(TRANSCRIPT_INFO_PANEL.EXEMPTIONS_ROW),
                     FilingStatus: returnValue(TRANSCRIPT_INFO_PANEL.FILING_STATUS_ROW),
                     AGI: returnValue(TRANSCRIPT_INFO_PANEL.AGI_ROW),
                     Deductions: returnValue(TRANSCRIPT_INFO_PANEL.DEDUCTION_ROW),
                     TaxesDue: returnValue(BALANCE_SUMMARY.TAX_DUE),
                     PaymentsMade: returnValue(BALANCE_SUMMARY.PMT_MADE), 
                     BalanceDue: returnValue(BALANCE_SUMMARY.BALANCE_DUE),
                     GetTranscriptLink: TRANSCRIPT_INFO_PANEL.GET_TRANSCRIPT_LINK
                  };
                  function returnValue(obj){
                    if(obj.WaitProperty('Exists',true,500)){
                      return obj.contentText;
                    }else{
                      return null;
                    }
                  }
                  Log.PopLogFolder();    
                  return taxRecordSummeryObj;
                }else{
                 Log.Error("Tax return Status Title could not be verified ",'',500,attr.err, PAGE);
                }
            Log.PopLogFolder();  
           }catch(e){
                Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
   
         }
} 

//function to get values in the form of JSON from account snapshot status table
function getStatus(){
     try{
          Log.AppendFolder("Get Return Status value from the Account Snapshot Page",'',500,attr.sub);
           var PAGE, RETURN_STATUS_PANE, taxReturnLatestObj, taxReturnHistoryObj, taxRecordSummeryObj;
               PAGE= Aliases.BROWSER.PAGE;
               RETURN_STATUS_PANE= PAGE.RETURN_STATUS_PANEL
               LATEST_STATUS = RETURN_STATUS_PANE.LATEST_STATUS;
               PAGE.WaitProperty("Exists",true,2000);
              if( PAGE.TAX_RETURN_TITLE.Exists){
                  Log.Checkpoint("Tax return Status Title verified ",'',500,attr.ver, PAGE.TAX_RETURN_TITLE);
                  //Return Status is unavailable
                  if(PAGE.NOT_AVAILABLE.WaitProperty("Exists",true,2000)){
                      taxReturnLatestObj = {
                              latestActivity:  returnValue(PAGE.NOT_AVAILABLE)
                        }
                  }else{
                        taxReturnLatestObj = {
                              latestActivity:  returnValue(LATEST_STATUS)
                        }
                  }
                  function returnValue(obj){
                    if(obj.WaitProperty("Exists",true,1000)){
                      return obj.contentText;
                    }else{
                      return null;
                    }
                  }
                  Log.PopLogFolder();
                  return taxReturnLatestObj;
                }else{
                 Log.Error("Tax return Status Title could not be verified ",'',500,attr.err, PAGE);
                }
           }catch(e){
                Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
   
         }
} 




