//USEUNIT UTIL
//USEUNIT CENSUS_HOME_PAGE_LIB

/********************************************************************************
TAG               : #REGRESSION TEST, #MUST PASS TEST 
Function Name     : AUT_TC101_Validate_search_feature_on_Census_Home_page
Description       : function to validate TC101
Date              : 03/27/2018
TE                : Bipin.R
Parameters        : searchText eg : test
Pre condition     : CENSUS HOME PAGE HAS TO BE LIVE
Objective         : N/A
********************************************************************************/
function unitTest_AUT_TC101_Validate_search_feature_on_Census_Home_page(){
  AUT_TC101_Validate_search_feature_on_Census_Home_page('test');
}

function AUT_TC101_Validate_search_feature_on_Census_Home_page(searchText){
   try{
          Log.AppendFolder("Validate \"Search Feature\" on census home page",'TC101',500,attr.par);
          CENSUS_HOME_PAGE_LIB.closeConnectedPanel();
          var PAGE = Aliases.BROWSER.PAGE;
          if(PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX.WaitProperty("Exists",true,15000)){
           Log.Checkpoint("Search text box is available on the header banner",'',500,attr.ver,PAGE.HEADER_PANEL.TOP_HEADER_PANEL);
            if(aqString.Compare(PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX.defaultValue,"Search",true)==0){
              Log.Checkpoint("Search text box has a default value of \"Search\"",'',500,attr.ver,PAGE.HEADER_PANEL.TOP_HEADER_PANEL);
               Log.AppendFolder("Search for Key word "+ searchText ,'',500,attr.sub);
                  _util_setText(PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX,searchText);
                  PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX.Keys("[Enter]");
                  Delay(1500,"Wait for search to end");
              Log.PopLogFolder();
              Log.AppendFolder("Vaidating Search result page",'',500,attr.val);   
                  if(findByText(PAGE,"Search results")){//Search results
                    Log.Checkpoint("User Landed to Search result page",'',500,attr.ver,PAGE );
                  }else{
                   throw "User did not land to Search result page";
                  }
                  if(PAGE.SEARCH_FORM.FIELDSET.SEARCHBOX.Text==searchText){
                    Log.Checkpoint("Search result for the search term \""+ searchText +"\" displayed on search box",'',500,attr.ver,PAGE );
                  }else{
                   throw "Search result for the search term "+ searchText +" did not display on saerch box";
                  }
              Log.PopLogFolder();     
            }else{
              throw "Search text box does not have a default value of \"Search\"";
            }
          }else{
            throw "Searchbox is not available on the census home page under header banner";
          }
          Log.PopLogFolder();
      }catch(e){
               Log.Error(e ,'',500,attr.err,Sys.Desktop);
  
      }
}