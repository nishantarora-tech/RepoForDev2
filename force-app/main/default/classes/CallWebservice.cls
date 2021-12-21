public class CallWebservice {
    private string cKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXX';
    private string cSecret = 'XXXXXXXXXXXXXXXXXXXXXXXXXXX';
    private string uName = 'XXXXXXXXXXXXXXXXXXXXXXXXXXX';
    private string passwd = 'Password+SecurityToken';
   
   
    public class responseWrapper {
        public string id;
        public string access_token;
        public string instance_url;
    }
    public class ContactWrapper {
        public string firstName;
        public string phone;
        public string email;
    }
    public string getRequestToken() {
        string reqBody = 'grant_type=password&client_id=' + cKey + '&client_secret=' + cSecret + '&username=' + uName + '&password=' + passwd;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse hresp = h.send(req);
        responseWrapper wResp = (responseWrapper) JSON.deserialize(hresp.getBody(), responseWrapper.class);
        system.debug('Instance url' + wResp.instance_url);
        system.debug('session id' + wResp.access_token);
        return wResp.access_token;
    }
    @future(callout = true)
    public static void getConList(Set < id > conIdSet) {
        String accToken;
        string responseBody;
        string endPoint = 'https://ap7.salesforce.com/services/apexrest/createAccountRecord';
        callWebservice obj = new callWebservice();
        accToken = obj.getRequestToken();
        system.debug('access token' + accToken);
        if (accToken != '') {
            for (Contact con: [SELECT id,name from Contact where id in: conIdSet]) {
                system.debug('JSON' + JSON.serialize(con));
                Http h1 = new Http();
                HttpRequest req1 = new HttpRequest();
                req1.setHeader('Authorization', 'Bearer ' + accToken);
                req1.setHeader('Content-Type', 'application/json');
                //req1.setHeader('accept','application/json');
                req1.setMethod('POST');
                req1.setBody(JSON.serialize(con));
                req1.setEndpoint(endPoint);
                HttpResponse hresp1 = h1.send(req1);
                system.debug('hresp1' + hresp1);
            }
        }
    }
   
}