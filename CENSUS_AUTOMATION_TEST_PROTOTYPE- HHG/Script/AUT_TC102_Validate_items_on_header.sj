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
Verify  link U.S. Department of Commerce is available	U.S. Department of Commerce is available
Verify  the link Blogs  is available	Blogs  is available
Verify  the link Index A-Z  is available	A-Z  is available
Verify  the link Glossary  is available	Glossary  is available
Verify  the link FAQs  is available	FAQs  is available
********************************************************************************/
function unitTest_AUT_TC102_Validate_items(){
Aliases.BROWSER.PAGE.ToUrl(Project.Variables.URL);
linksobj =  {
            "U.S. Department of Commerce": "https://www.commerce.gov/",
            "Blogs":"https://www.census.gov/about/contact-us/social_media.html",
            "Index A-Z":"https://www.census.gov/about/index.html",
            "Glossary":"https://www.census.gov/glossary/",
            "FAQs":"https://ask.census.gov/"
           };

  AUT_TC102_Validate_items(linksobj);

}
function AUT_TC102_Validate_items(links){
  try {
           var obj;
           for(var  i in links){
                Log.AppendFolder("Verifying the link title \""+i+"\" the census home top banner",'',500,attr.ver);
                      
                      obj =Aliases.BROWSER.PAGE.HEADER_PANEL.FindChild(["ObjectType","contentText"],["Link",i],9)
                      
                      //obj = findByText(Aliases.BROWSER.PAGE.HEADER_PANEL,i);
                      if(obj!=undefined){
                        Log.Checkpoint(i + " link titile is available on the banner",'',500,attr.ver);
                      }else{
                        Log.Error(i + " link titile is not available on the banner",'',500,attr.err);
                      }
                Log.PopLogFolder();
                Log.AppendFolder("Verifying the link href \""+links[i]+"\" on top banner",'',500,attr.ver);
                    if(obj.href==links[i]){
                    obj.HoverMouse();
                     Log.Message(links[i]+ " link is available on Banner",'',500,attr.ver);
                    }else{
                     Log.Error(links[i]+ " link is not available on Banner",'',500,attr.err) ;
                    }
                Log.PopLogFolder();
           }
  }catch(e){
       Log.Error(e ,'',500,attr.err,Sys.Desktop);

  }
}
