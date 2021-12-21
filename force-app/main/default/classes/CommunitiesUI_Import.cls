global class CommunitiesUI_Import{ 
    public CommunitiesUI_Import(CommunitiesUI_Controller controller) {

    }       
    webService static List<ImportLeadResponse> importLeads(List<LeadInsertion> LeadInsertionObj){       
        // Response Instance List
        List<ImportLeadResponse> responseObjList = new List<ImportLeadResponse>(); 
               
        Map<Id,Lead> leadMap = new Map<Id,Lead>(); 
        Set<String> campaignNames = new Set<String>();                        
        List<Lead> leadObjList = new List<Lead>();
        Map<String,Id> campaignMap = new Map<String,Id>();
        /*for(CommunitiesUI_Controller.LeadInsertion lead : LeadInsertionObj){
            campaignNames.add(lead.Campaign);
        }
        for(Campaign campaignObj : [select id,name from Campaign where name In: campaignNames]){
            campaignMap.put(campaignObj.name,campaignObj.id);
        }*/ 
        for(LeadInsertion lead : LeadInsertionObj){            
            Lead leadObj = new Lead();
            leadObj.firstName = lead.firstName;
            leadObj.lastName = lead.lastName;
            leadObj.company = lead.Company;
            //leadObj.Campaign = campaignMap.get(lead.Campaign);
            leadObj.Description = lead.Description;
            leadObj.LeadSource = lead.LeadSource;            
            leadObj.Email = lead.Email;
            leadObj.MobilePhone = lead.Mobile;                
            leadObj.Phone = lead.Phone;
            leadObj.Street = lead.Address.Street;
            leadObj.City = lead.Address.City;
            leadObj.State = lead.Address.State;
            leadObj.PostalCode = lead.Address.PostalCode;
            leadObj.Country = lead.Address.Country;
            leadObj.Website = lead.Website;
            leadObj.Fax = lead.Fax;
            leadObj.Industry = lead.Industry;                                           
            leadObjList.add(leadObj);                            
        }        
        try{
            // DML statement                        
            Database.SaveResult[] srObjList = Database.insert(leadObjList,false);                                
            if(leadObjList.size()>0){
                for(Lead leadObject :leadObjList){
                  leadMap.put(leadObject.id,leadObject);                  
                }
            }                              
            // Map for getting Lead Id Number of Created records
            Map<Id,Lead> leadIDNumberMap = new Map<Id,Lead>([select Lead_ID_Number__c from Lead where Id In: leadMap.keyset()]);                                                        
            for(Database.SaveResult srObj : srObjList){        
                // Success Response
                if(srObj.isSuccess()) {                                              
                    // Response Instance
                    ImportLeadResponse responseObj = new ImportLeadResponse();
                    responseObj.SFLeadID = srObj.getId();
                    responseObj.firstName = leadMap.get(srObj.getId()).firstName;
                    responseObj.lastName = leadMap.get(srObj.getId()).lastName;
                    responseObj.company = leadMap.get(srObj.getId()).Company; 
                    responseObj.LeadIDNumber = leadIDNumberMap.get(srObj.getId()).Lead_ID_Number__c;
                    responseObj.ErrorDetail = '';
                    responseObjList.add(responseObj);                            
                }
                else{
                    // Error Response                                                                                                            
                    for(Database.Error err : srObj.getErrors()){
                        // Response Instance
                        ImportLeadResponse responseObj = new ImportLeadResponse();
                        responseObj.ErrorDetail = err.getMessage();
                        responseObj.firstName = leadMap.get(srObj.getId()).firstName;
                        responseObj.lastName = leadMap.get(srObj.getId()).lastName;
                        responseObj.company = leadMap.get(srObj.getId()).Company;
                        responseObj.SFLeadID = '';
                        responseObj.LeadIDNumber = '';
                        responseObjList.add(responseObj);
                    }                
                }             
            }              
        }Catch(DmlException e){            
            // Response Instance
            ImportLeadResponse responseObj = new ImportLeadResponse();
            system.debug('ListException----'+e.getMessage());
            responseObj.ErrorDetail = e.getMessage();
            responseObjList.add(responseObj);
        }                                      
        return responseObjList;            
    }        
    global Class ImportLeadResponse{                 
        webService String LeadIDNumber;
        webService String FirstName;
        webService String LastName;
        webService String Company; 
        webService String SFLeadID;                           
        webService String ErrorDetail;                                                      
    }
    global Class AddressInfo{
        webService String Street;
        webService String City;
        webService String State;
        webService String Country;
        webService String PostalCode;
    }
    global Class LeadInsertion{        
        webService String firstName;
        webService String lastName;
        webService String Company;                
        webService String Phone;
        webService String Mobile;
        webService String Extension;
        webService String Fax;
        webService String Website;        
        webService String Email;        
        webService String Description;
        webService String LeadSource;
        webService String Campaign;
        webService String Industry;
        webService CommunitiesUI_Controller.AddressInfo Address;             
    }       
}