@isTest
public class AccountContactInfoControllerTest
{  
    public static testMethod void  accountContact()
    {
        PageReference pageRef = Page.AccountContactInfo;
        Test.setCurrentPage(pageRef);
        Account Acc= new Account();
        Acc.Name='test';        
        ApexPages.StandardController sc = new ApexPages.StandardController(Acc);
        AccountContactInfoController accConObj= new AccountContactInfoController(sc); 
        Contact con=new Contact();  
        con.LastName='test';
        test.startTest();
        accConObj.con = con;       
        accConObj.add();
        accConObj.save();         
        accConObj.addMore();                      
        accConObj.clear();
        accConObj.cancel();
        test.stopTest();
    }
}