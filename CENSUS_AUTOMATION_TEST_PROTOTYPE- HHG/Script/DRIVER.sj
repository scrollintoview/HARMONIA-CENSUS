//USEUNIT Account_Snapshot_Lib
//USEUNIT Function_Library
//USEUNIT Login_Page_Lib
//USEUNIT MyAccount_Page_Lib
//USEUNIT Utility_Lib


/********************************************************************************
Function Name     :TestDriver
Description       :This is the function to loop through the Master Test Data and determine the flow of the application
Author            :Bipin.R (Harmonia Holding Group. LLC)
Return            :N/A 
Parameters        :N/A
Additional info   :MasterTD has following columns User ID	Password	User	Return Status	Refund Status,	Balance Due,	Payments Made,	Refund Due,
                    AGI,	Decuctions,	Excemptions,	Filing Status,

********************************************************************************/
function TestDriver(){
//      try{
              var TEST_DATA= ProjectSuite.Variables.TEST_DATA;
              TEST_DATA.Reset();
              var i=0;
              while(!TEST_DATA.IsEOF()){
               i++;
                Log.AppendFolder("Scenario: "+i+ ".- Testing IRS- UX/UI Agile Prototype Application as \""+TEST_DATA.Value("User Name")+"\"",'',500,attr.par );
                             Log.AppendFolder("Login as \""+TEST_DATA.Value("User")+"\"",'',500,attr.sub);
                               Log.Message("Expected User Name : \""+TEST_DATA.Value("User Name")+"\"");
                               testlogin(TEST_DATA.Value("User"),Project.Variables.PASSWORD,TEST_DATA.Value("User Name"));
                             Log.PopLogFolder();
                             //navigateToMyAccountPage(); // navigating to ac snapshot project
                             isMakePayment = TEST_DATA.Value("Make Payment"); 
                             isRefundLink  = TEST_DATA.Value("Refund Link"); 
                             Test_Account_Snapshot(isMakePayment,isRefundLink);
                             var summary = MyAccount_Page_Lib.getTaxRecordSummary();  // get Tax Records Summary
                             var status = MyAccount_Page_Lib.getStatus(); //get Status
                             Log.AppendFolder("**** Test Tax Return and Refund Status *****",'',500,attr.sub);
                                     Log.AppendFolder("Validate \" Current Return and Refund status\" is \""+TEST_DATA.Value("Status")+"\"",'',500,attr.val);
                                      if(aqString.Find(status.latestActivity,TEST_DATA.Value("Status"))>-1){
                                        Log.Checkpoint("Test Pass: Expected Status: \""+TEST_DATA.Value("Status")+"; Actual Status: \""+status.latestActivity+"\"",'',500,attr.ver,Sys.Desktop);
                                      }else{
                                        Log.Error("Error: Expected Status: \""+TEST_DATA.Value("Status")+"; Actual Status: \""+status.latestActivity+"\"",'',500,attr.err,Sys.Desktop);
                                      }
                                     Log.PopLogFolder();
//                                     Log.AppendFolder("Validate \"Refund status\" is \""+TEST_DATA.Value("Refund Status")+"\"",'',500,attr.val);
//                                       Log.Checkpoint("Call Test Refund()",'',500,attr.ver);
//                                       //testRefund(TEST_DATA.Value("Return Status"))   ;// true is pass false is fail  
//                                     Log.PopLogFolder();
                             Log.PopLogFolder();        
                             //__________________
                             Log.AppendFolder("**** Test Tax Record Summary ****",'',500,attr.sub);
                                     Log.AppendFolder("Validate \"Balance Due\" is \""+TEST_DATA.Value("Balance Due")+"\"",'',500,attr.val);
                                           if(TEST_DATA.Value("Balance Due")==null){
                                                 if(summary.BalanceDue==TEST_DATA.Value("Balance Due")){
                                                    Log.Checkpoint("Balance Due is validated",'',500,attr.ver);
                                                 }else{
                                                    Log.Error("Expected : " +TEST_DATA.Value("Balance Due")+"; Actual value : "+ summary.BalanceDue,'',500,attr.err,Sys.Desktop);
                                                 }
                                           }
                                           else if(aqString.Find(summary.BalanceDue,TEST_DATA.Value("Balance Due"),0,false)>-1){
                                              Log.Checkpoint("\"Balance Due\" is validated\"",'',500,attr.ver);
                                            }else{
                                             Log.Error("Expected : " +TEST_DATA.Value("Balance Due")+"; Actual value : "+ summary.BalanceDue,'',500,attr.err,Sys.Desktop);
                                            }
                                     Log.PopLogFolder();
                                     
                                     Log.AppendFolder("Validate \"Payments Made\" is \""+TEST_DATA.Value("Payments Made")+"\" ",'',500,attr.val);
                                           if(TEST_DATA.Value("Payments Made")==null){
                                                       if(summary.PaymentsMade==TEST_DATA.Value("Payments Made")){
                                                          Log.Checkpoint("Payment made validated",'',500,attr.ver);
                                                       }else{
                                                         Log.Error("Expected : " +TEST_DATA.Value("Payments Made")+"; Actual value : "+summary.PaymentsMade ,'',500,attr.err,Sys.Desktop);
                                                       }
                                                 }
                                           else if(aqString.Find(summary.PaymentsMade,TEST_DATA.Value("Payments Made"),0,false)>-1){
                                              Log.Checkpoint("Payment made validated",'',500,attr.ver);
                                            }else{
                                             Log.Error("Expected : " +TEST_DATA.Value("Payments Made")+"; Actual value : "+summary.PaymentsMade ,'',500,attr.err,Sys.Desktop);
                                            }
                                     Log.PopLogFolder();
                                     
                                     Log.AppendFolder("Validate \"Refund Due\" is \""+TEST_DATA.Value("Refund Due")+"\"",'',500,attr.val);
                                         if(TEST_DATA.Value("Refund Due")==null){
                                                           if(summary.TaxesDue==TEST_DATA.Value("Refund Due")){
                                                              Log.Checkpoint("Refund due validated",'',500,attr.ver);
                                                           }else{
                                                             Log.Error("Expected : " +TEST_DATA.Value("Refund Due")+"; Actual value : "+summary.TaxesDue ,'',500,attr.err,Sys.Desktop);
                                                           }
                                                     }
                                         else if(aqString.Find(summary.TaxesDue,TEST_DATA.Value("Refund Due"),0,false)>-1){
                                            Log.Checkpoint("Refund due validated",'',500,attr.ver);
                                          }else{
                                           Log.Error("Expected : " +TEST_DATA.Value("Refund Due")+"; Actual value : "+summary.TaxesDue ,'',500,attr.err,Sys.Desktop);
                                          } 
                                     Log.PopLogFolder();
                                     
                                     //  AGI	Decuctions	Excemptions	Filing Status
                                     Log.AppendFolder("Validate \"Adjusted Gross Income\" is \""+TEST_DATA.Value("AGI")+"\"",'',500,attr.val);
                                     if(aqString.Find(summary.AGI,TEST_DATA.Value("AGI"),0,false)>-1){
                                        Log.Checkpoint("AGI Value validated",'',500,attr.ver);
                                      }else{
                                       Log.Error("Expected : " +TEST_DATA.Value("AGI")+"; Actual value : "+summary.AGI ,'',500,attr.err,Sys.Desktop);
                                      }
                                     Log.PopLogFolder();
                                     
                                     Log.AppendFolder("Validate \"Deductions\" is \""+TEST_DATA.Value("Deductions")+"\"",'',500,attr.val);
                                      if(aqString.Find(summary.Deductions,TEST_DATA.Value("Deductions"),0,false)>-1){
                                        Log.Checkpoint("Validating Deductions value",'',500,attr.ver)
                                      }else{
                                       Log.Error("Expected : " +TEST_DATA.Value("Deductions")+"; Actual value : "+ summary.Deductions,'',500,attr.err,Sys.Desktop);
                                      }
                                     Log.PopLogFolder();
                                     
                                     Log.AppendFolder("Validate \"Filing Status\" is \""+TEST_DATA.Value("Filing Status")+"\"",'',500,attr.val);
                                     if(TEST_DATA.Value("Filing Status")==null){
                                                           if(summary.FilingStatus==TEST_DATA.Value("Filing Status")){
                                                              Log.Checkpoint("Filing Status Validated",'',500,attr.ver);
                                                           }else{
                                                             Log.Error("Expected : " +TEST_DATA.Value("Filing Status")+"; Actual value : "+summary.FilingStatus ,'',500,attr.err,Sys.Desktop);
                                                           }
                                                     }
                                     else if(aqString.Find(summary.FilingStatus,TEST_DATA.Value("Filing Status"),0,false)>-1){
                                        Log.Checkpoint("Filing Status Validated",'',500,attr.ver)
                                      }else{
                                       Log.Error("Expected : " +TEST_DATA.Value("Filing Status")+"; Actual value : "+summary.FilingStatus ,'',500,attr.err,Sys.Desktop);
                                      }
                                     Log.PopLogFolder();    
                             Log.PopLogFolder();
                             //__________________  
                             logout();//logout
                         Log.PopLogFolder();
                        TEST_DATA.Next();
                    Log.PopLogFolder();  
              }
//         }catch(e){
//                Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
//      }
}