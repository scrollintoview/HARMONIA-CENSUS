﻿//USEUNIT UTIL

// Function to test the UI Comonenets of Account Snapshot Page


function Test_Account_Snapshot(isMakePayment,isRefundLink){
      try{
                Log.AppendFolder("**** Testing UI elements on Account snapshot Page ****",'',500,attr.sub);
                       var PAGE = Aliases.BROWSER.PAGE;
                       if(PAGE.WaitProperty("Exists",true,3000)){
                               if(PAGE.MY_AC_TEXT_NODE.WaitProperty("Exists",true,5000)){//checking My Account Header
                                   Log.Checkpoint("User Landed to Account snapshot page after Logining in",'',500,attr.ver,Sys.Desktop);
                                  }else{
                                   Log.Error("Error: User did not land to Account Snapshot page",'',500,attr.err,Sys.Desktop);
                                  }
                               if(PAGE.TAX_YYYY.Exists){//checking year dropdown
                                   Log.Checkpoint("Tax Year dropdown verified",'',500,attr.ver,Sys.Desktop)
                                 }else{
                                   Log.Error("Error: Tax Year dropdown could not be verified",'',500,attr.err,Sys.Desktop);
                               }
                               if(PAGE.LOGO_IMAGE.ObjectType=="Image"&&PAGE.LOGO_IMAGE.Exists==true){//logo check
                                   Log.Checkpoint("Logo in Header is verified",'',500,attr.ver,Sys.Desktop)
                                 }else{
                                   Log.Error("Error: Logo in Header could not be verified",'',500,attr.err,Sys.Desktop);
                               }
                               if(PAGE.TAX_RECORD_SUMMARY_HEADER.Exists){//check tax record summary Label
                                   Log.Checkpoint("Tax Record Summary is available on the Account snapshot page",'',500,attr.ver,Sys.Desktop)
                                 }else{
                                   Log.Error("Error: Tax Record Summary is not available on the Account snapshot page",'',500,attr.err,Sys.Desktop);
                               }
                               if(PAGE.TAX_RETURN_TITLE.Exists){//check Tax Return Status Label
                                   Log.Checkpoint("Tax Return Status is available on the Account snapshot page",'',500,attr.ver,Sys.Desktop)
                                 }else{
                                   Log.Error("Error: Tax Return Status is not available on the Account snapshot page",'',500,attr.err,Sys.Desktop);
                               }
                               if(isMakePayment=="TRUE"){
                                 if(PAGE.BALANCE_SUMMARY.MK_PMT_BTN.WaitProperty("Exists",true,1000)){//check make Payment Button
                                   Log.Checkpoint("Make Payment button is available on the Account snapshot page",'',500,attr.ver,Sys.Desktop)
                                 }else{
                                   Log.Error("Error: Make Payment button is not available on the Account snapshot page",'',500,attr.err,Sys.Desktop);
                                 }
                               }
                               if(isRefundLink=="TRUE"){//check WHERE_IS_MY_REFUND_LINK
                                 if(PAGE.RETURN_STATUS_PANEL.LATEST_STATUS.WHERE_IS_MY_REFUND_LINK.WaitProperty("Exists",true,1000)){
                                     Log.Checkpoint("Where\'s My Refund link is available on the Account snapshot page",'',500,attr.ver,Sys.Desktop)
                                   }else{
                                     Log.Error("Error: Where\'s My Refund is not available on the Account snapshot page",'',500,attr.err,Sys.Desktop);
                                   }
                              }
                        }else{
                          Log.Error("Error: Account Snapshot page is not available",'',500,attr.err,Sys.Desktop);
                        }
                    Log.PopLogFolder();  
         }catch(e){
                Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
         }
   }