//USEUNIT Function_Library

function testlogin(user,passWord,userName){
  var userAlias, passwordAlias, LoginbtnAlias;
  var PAGE = Aliases.BROWSER.PAGE;
  userAlias= PAGE.LOGIN_FORM.SELECT_USER;
  passwordAlias= PAGE.LOGIN_FORM.PASSWORD
  LoginbtnAlias= PAGE.LOGIN_FORM.LOGIN_BTN;
     if( login(userAlias, user, passwordAlias, passWord, LoginbtnAlias)==false){
       Runner.Stop("Could not log in to the Test Site");
     }
     //@Test
    var AC_SNAPSHOT_PG=  PAGE;
    var USER_LINK = AC_SNAPSHOT_PG.LOGOUT_FORM.USER_LINK;
        USER_LINK.WaitProperty("Exists",true,30000);
        if( aqString.Find(USER_LINK.contentText,userName,0,false)>-1){
           Log.Checkpoint("Logged in user validated Expected : "+userName+ ", Actual "+ USER_LINK.contentText,'',500,attr.val,Sys.Desktop);
        }else{
          Log.Error("Error: Logged in user could not be validated; Expected : "+userName+ ", Actual "+ USER_LINK.contentText,'',500,attr.val,Sys.Desktop);
        }
}

function logout(){
     try{
           Log.AppendFolder("Log Off from the Application",'',500,attr.sub);
                var AC_SNAPSHOT_PG =  Aliases.BROWSER.PAGE;
                var LOG_OFF_LINK   =  AC_SNAPSHOT_PG.LOG_OFF_LINK;
                    LOG_OFF_LINK.WaitProperty("Exists",true,30000);
                    LOG_OFF_LINK.Click();
           Log.PopLogFolder();         
         }catch(e){
                Log.Error("TRY CATCH ERR -- "+ e.message + " ERROR DESCRIPTION -- "+ e.description + " on --" +arguments.callee.toString().match(/function\s+\w+/)  );
         }

}

