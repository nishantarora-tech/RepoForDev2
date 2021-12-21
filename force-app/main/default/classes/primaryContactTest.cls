@isTest
public class primaryContactTest{
    @isTest
    public static void unitTest(){
        List<Opportunity> oppList = new List<Opportunity>();
        Account acc = new Account();
        acc.Name ='Demo Acc';
        insert acc;
        
        Contact con = new Contact();
        con.Primary__c= true;
        con.FirstName = 'Demo';
        con.Lastname = 'Con';
        con.AccountId = acc.id;
        insert con;
        
        for(integer i=0 ; i<299;i++){
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.id;
            opp.Name = 'Demo Opp';
            opp.Stagename = 'Prospecting';
            opp.Closedate = date.today();
            oppList.add(opp);
        }
        insert oppList;
        system.assertEquals(con.id,OppList[0].Contact__c);
       
    }
}