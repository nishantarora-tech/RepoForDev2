@RestResource(UrlMapping = '/v1/Accounts/*')
global class Rest_Account{
    @HttpGet
    global static Account doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;        
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);        
        Account account = [SELECT Id,name FROM Account WHERE Id = :accountId];
        return account ;
    }
    @HttpPost
    global static Account doPost(String name) 
    {
        Account acc = new Account();
        acc.name= name;        
        insert acc;        
        return acc;
    }
}