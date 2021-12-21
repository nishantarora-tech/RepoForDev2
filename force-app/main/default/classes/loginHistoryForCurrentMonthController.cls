public class loginHistoryForCurrentMonthController {
    public Integer totalRecords{get;set;} 
    public loginHistoryForCurrentMonthController (){
        totalRecords = 0;
    }
    public void loginHistory(){
        totalRecords = 0;
        String userName = ApexPages.currentpage().getParameters().get('userN');
        if(!String.isBlank(userName)){                        
            List<User> usr = [select id from User where username = :userName];
            if(usr.size()>0){
                List<LoginHistory> lstLoginHistory = [select userId from LoginHistory where userId =:usr[0].id and LoginTime = This_Month];            
                if(lstLoginHistory.size() >0){
                    for(LoginHistory obj :lstLoginHistory ){
                       totalRecords++;
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'No login history found for this User'));            
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a valid username.'));            
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a username.'));            
        }
        system.debug('totalRecords----'+totalRecords);                    
    }
}