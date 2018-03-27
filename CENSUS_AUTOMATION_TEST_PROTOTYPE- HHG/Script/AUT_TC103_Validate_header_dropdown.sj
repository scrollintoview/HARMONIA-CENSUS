


//USEUNIT UTIL
//USEUNIT CENSUS_HOME_PAGE_LIB

/********************************************************************************
TAG               : #REGRESSION TEST, #MUST PASS TEST 
Function Name     : AUT_TC102_Validate_items_on_header_top_links
Description       : function to validate TC102
Date              : 03/27/2018
TE                : Bipin.R
Parameters        : N/A
Pre condition     : CENSUS HOME PAGE HAS TO BE LIVE
Objective         : 
Verify TOPICS
            Verify TOPICS sub menu is available
            Verify GEOGRAPHY sub menu is available
            Verify LIBRARY sub menu is available
            Verify DATA sub menu is available
            Verify SURVEYS/PROGRAMS sub menu is available
            Verify NEWSROOM sub menu is available
            Verify ABOUT US sub menu is available

********************************************************************************/

function unitTest_AUT_TC103_Validate_topics_drop_down_menus(){
    var menuitems = {
      item1 :"TOPICS",
      item2 :"GEOGRAPHY",
      item3 :"LIBRARY",
      item4 :"DATA",
      item5 :"SURVEYS/PROGRAMS",
      item6 :"NEWSROOM",
      item7 :"ABOUT US"
     };
     AUT_TC102_Validate_items(menuitems);
}

function AUT_TC102_Validate_items(menuitems){
 try{
     var dropdownitemsObj = getHeaderMenuItems();
     for(var k in menuitems){
         for(obj in dropdownitemsObj){
           if(menuitems[k]==dropdownitemsObj[obj].innerText){
               Log.AppendFolder("Selecting and Validating the dropdown menu for \""+menuitems[k]+"\"",'',500,attr.val);
                 dropdownitemsObj[obj].Click();
                 Log.Checkpoint("\""+menuitems[k]+"\" validated",'',500,attr.val,dropdownitemsObj[obj]);
               Log.PopLogFolder();  
           }
         }
     }
      }catch(e){
       Log.Error(e ,'',500,attr.err,Sys.Desktop);
     }
}


function getHeaderMenuItems(){
try{
            Log.AppendFolder("Retriving dropdown menu items from the on header top links",'',500,attr.par);
             var PAGE = Aliases.BROWSER.PAGE; 
             var TOP_HEADER_PANEL =  PAGE.HEADER_PANEL;
             if(TOP_HEADER_PANEL.WaitProperty("Exists",true,1500)){
                   Log.Checkpoint("Top Header panel is available on census home page",'',500,attr.ver,TOP_HEADER_PANEL );
                       var menuItems  = TOP_HEADER_PANEL.querySelectorAll("div.header")   ;
                           menuItems = menuItems.toArray();
                           // Log.Message(menuItems.length)
                           if(menuItems.length==7){
                              Log.Checkpoint("There are 7 dropdown menus available on the census home page",'',500,attr.ver);
                              var menuTitles = [];
                              for(var items in menuItems){
                                Log.Message("Storing: "+ menuItems[items].innerText);
                                menuTitles.push(menuItems[items]);
                              }
                         }else{
                             throw "Expected dropdown menu are 8 actual is "+ menuItems.length
                         }
                        
                 }else{
                  throw "Header panel is not available on census home page";
                 }
          Log.PopLogFolder();  
          return   menuTitles;
      }catch(e){
       Log.Error(e ,'',500,attr.err,Sys.Desktop);
    }
}