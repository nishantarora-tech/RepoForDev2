public class AccessReportANDDashboardRESTAPI {                       
    @future(callout=true) 
    public static void getReportAndDashboard(string name){
        //Set<Id> reportIds = new Set<Id>();       
        List<DashboardComponent> cmt = [Select name,customReportId,dashboardId from DashboardComponent where dashboardId ='01Z0o000000uvTz'];
        Map<Id,DashboardComponent> reportToDashboardId = new Map<Id,DashboardComponent>();
        for(DashboardComponent dash : cmt){
            reportToDashboardId.put(dash.customReportId,dash);
        }
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm(); 
        String restAPIURL = sfdcURL + '/services/data/v48.0/analytics/dashboards/01Z0o000000uvTz';                           
        String jsonBody = '{"folderId" : "00l0o00000301ZuAAI","name" : "Test15REST6"}';                                            
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setMethod('GET');   
        httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());        
        httpRequest.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        //httpRequest.setBody(jsonBody);
        httpRequest.setEndpoint(restAPIURL);
        
        //String response = '';
        
        Http h1 = new Http();                     
        HttpResponse httpResponse= h1.send(httpRequest);
        if(httpResponse.getStatusCode() == 200 ){              
            Type resultType = Type.forName('ComponentResponse');
            ComponentResponse deserializeResults = (ComponentResponse)JSON.deserialize(httpResponse.getBody(), resultType);
            for(ComponentResponse.component comp : deserializeResults.componentData){
                //system.debug('comp.componentId----'+comp.componentId);
                system.debug('comp.reportId----'+comp.reportResult.reportMetadata.name);
                //system.debug('comp.name----'+comp.name);
                /*restAPIURL = sfdcURL + '/services/data/v48.0/analytics/reports/?cloneId='+comp.reportResult.reportMetadata.Id;
                HttpRequest httpRequest2 = new HttpRequest();
                httpRequest2.setMethod('POST');   
                httpRequest2.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());        
                httpRequest2.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
                httpRequest2.setHeader('Content-Type', 'application/json;charset=UTF-8');
                String jsonBody2 = '{"reportMetadata" : {"name" : '+comp.reportResult.reportMetadata.name+'123'+',"reportFilters" : [{"column":"CONVERTED","operator":"equals","value":"false"} ]}}';
                httpRequest2.setBody(jsonBody2);
                httpRequest2.setEndpoint(restAPIURL);
                Http h2 = new Http(); 
                HttpResponse httpResponse2= h2.send(httpRequest2);
                system.debug('httpResponse2----'+httpResponse2.getBody());*/
            }
            //AccessReportANDDashboardRESTAPI.response response = (AccessReportANDDashboardRESTAPI.response)JSON.deserialize(httpResponse.getBody(), AccessReportANDDashboardRESTAPI.response.class);                      
            /*Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(httpResponse.getBody());
            List<Object> lstCustomers = (List<Object>)results.get('componentData');           
            for (Object customer : lstCustomers) {
                // now get attributes for this customer.
                Map<String, Object> customerAttributes = (Map<String, Object>)customer;
                // now loop through our customer attributes.
                for (String attributeName : customerAttributes.keyset()) {
                    // handle response
                    if(attributeName == 'reportResult'){
                        Map<String, List<Object>> customerAttributes2 = (Map<String, List<Object>>)customer;
                        for(Object reportMdt : customerAttributes2.get(attributeName)){
                            system.debug('reportMdt ----'+reportMdt );
                        }
                    }
                    // System.debug('========> ' + attributeName + ' = ' + 
                    //customerAttributes.get(attributeName));
                }
            }
            system.debug('httpResponse.getBody()----'+httpResponse.getBody());
            system.debug('reportIds----'+reportIds);*/
            system.debug('httpResponse.getBody()----'+httpResponse.getBody());
            system.debug('deserializeResults----'+deserializeResults);
        }else {  
            System.debug(' httpResponse ' + httpResponse.getBody());  
            throw new CalloutException( httpResponse.getBody() );  
        }                                                    
    }     
}