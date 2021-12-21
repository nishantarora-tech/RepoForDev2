@isTest(seeAlldata=true)
public class loginHistoryForCurrentMonthTest{
    @isTest public static void loginhistoryMethod(){
        loginHistoryForCurrentMonthController obj = new loginHistoryForCurrentMonthController(); 
        PageReference pageRef = Page.loginHistoryForCurrentMonth;
        Test.setCurrentPage(pageRef);
        
        List<User> usrList = new List<User>();       
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User usr = [select id from user where id =:userInfo.getuserId()];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser12341@test.com'); 
        ApexPages.currentPage().getParameters().put('userN', u.UserName);       
        usrList.add(u);
        insert usrList;
        
        obj.loginHistory();       
        
    }    
}