public class SendAccountAndContactUsingRESTAPI {    
    public class deserializeResponse{
        public String id;
        public String access_token;
    }
    public String ReturnAccessToken (SendAccountAndContactUsingRESTAPI account){
        Profile pf = [select id from Profile where name ='System Administrator'];
        Connected_Apps_Cs__c csObj = [select Client_Id__c,Client_Secret__c,Password__c,Username__c from Connected_Apps_Cs__c where SetupOwnerId =:pf.id];
        String reqbody = 'grant_type=password&client_id='+csObj.Client_Id__c+'&client_secret='+csObj.Client_Secret__c+'&username='+csObj.Username__c+'&password='+csObj.Password__c;
        system.debug('csObj----'+csObj); 
        system.debug('reqbody----'+reqbody);        
        Http h = new Http();
        HttpRequest req = new HttpRequest();        
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse res = h.send(req);
        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);        
        return resp1.access_token;
    }
    @future(callout=true) 
    public static void createAccountAndContact(String accName,String contactFirstName,string contactLastName){
        SendAccountAndContactUsingRESTAPI account1 = new SendAccountAndContactUsingRESTAPI();
        String accessToken;                
        //accessToken = account1.ReturnAccessToken (account1); 
        system.debug('accessToken----'+accessToken);       
        //if(accessToken != null){
            String endPoint = 'https://nizy-serviceprovider-dev-ed.my.salesforce.com/services/apexrest/v1/getAccounts/';                    
            Http h2 = new Http();
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('accName', accName );
            gen.writeStringField('conFirstName', contactFirstName);
            gen.writeStringField('conLastName', contactLastName);
            gen.writeEndObject();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(gen.getAsString());                        
            req1.setMethod('POST');            
            //req1.setEndpoint(endPoint);
            req1.setEndpoint('callout:NamedCredentialForDevOrg2/services/apexrest/v1/getAccounts');                                 
            HttpResponse res1 = h2.send(req1);    
            system.debug('===>res1'+res1);   
            String jsonInput = res1.getBody();            
            system.debug('===>jsonInput'+jsonInput);                                           
            
        //}            
     }
     
}