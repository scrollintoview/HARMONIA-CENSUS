//USEUNIT UTIL
//USEUNIT CENSUS_HOME_PAGE_LIB

/********************************************************************************
TAG               : #SMOKE TEST
Function Name     : 
Description       : function to perform smoke test
Date              : 03/27/2018
TE                : Bipin.R
Parameters        : N/A
Pre condition     : CENSUS HOME PAGE HAS TO BE LIVE
Objective         : N/A
********************************************************************************/
function SMOKE_TEST(){
try{
CENSUS_HOME_PAGE_LIB.closeConnectedPanel();
        Log.AppendFolder("Verify if the application navigated to Census.gov",'',500,attr.val);
           aqObject.CheckProperty(Aliases.BROWSER.PAGE, "URL", cmpContains, "census.gov", false);
        Log.PopLogFolder();   
        Log.AppendFolder("Verify if SEARCHBOX is available on Census.gov",'',500,attr.val);   
           aqObject.CheckProperty(Aliases.BROWSER.PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX, "Visible", cmpEqual, true);
        Log.PopLogFolder();  
        Log.AppendFolder("Verify if census trademark is available on the header banner on Census.gov",'',500,attr.val);   
           aqObject.CheckProperty(Aliases.BROWSER.PAGE.HEADER_PANEL.imageUscensusIdentitySoloWhite2i, "Visible", cmpEqual, true);
        Log.PopLogFolder();  
        Log.AppendFolder("Verify if the Footer is available on Census.gov",'',500,attr.val);   
        Aliases.BROWSER.PAGE.panelFootercontainer.panel.scrollIntoView();
           aqObject.CheckProperty(Aliases.BROWSER.PAGE.panelFootercontainer.panel, "Visible", cmpEqual, true);
        Log.PopLogFolder(); 
       Log.AppendFolder("Verify if the TOP_HEADER_PANEL is available on Census.gov",'',500,attr.val);    
       Aliases.BROWSER.PAGE.HEADER_PANEL.TOP_HEADER_PANEL.scrollIntoView();
           aqObject.CheckProperty(Aliases.BROWSER.PAGE.HEADER_PANEL.TOP_HEADER_PANEL, "Visible", cmpEqual, true);
        Log.PopLogFolder(); 
 }catch(e){
  Log.Error(e.name ,'',500,attr.err,Sys.Desktop);
 }
}