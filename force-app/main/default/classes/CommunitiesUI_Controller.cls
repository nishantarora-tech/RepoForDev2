global with sharing class CommunitiesUI_Controller{        
        public List<Account> accList{get;set;}
        public List<Contact> conList{get;set;}
        public List<Lead> leadList{get;set;}    
        public List<Opportunity> oppList{get;set;}
        public Integer days{get;set;}
        public String target {get;set;}         
        public CommunitiesUI_Controller(){                                                
           days = 30;                  
        } 
        /********************** Import Lead Method *********************/  
        webService static List<CommunitiesUI_Controller.ImportLeadResponse> importLeads(List<CommunitiesUI_Controller.LeadInsertion> LeadInsertionObj){       
            // Response Instance List
            List<CommunitiesUI_Controller.ImportLeadResponse> responseObjList = new List<CommunitiesUI_Controller.ImportLeadResponse>();        
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
            for(CommunitiesUI_Controller.LeadInsertion lead : LeadInsertionObj){            
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
                        CommunitiesUI_Controller.ImportLeadResponse responseObj = new CommunitiesUI_Controller.ImportLeadResponse();
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
                            CommunitiesUI_Controller.ImportLeadResponse responseObj = new CommunitiesUI_Controller.ImportLeadResponse();
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
                CommunitiesUI_Controller.ImportLeadResponse responseObj = new CommunitiesUI_Controller.ImportLeadResponse();
                system.debug('ListException----'+e.getMessage());
                responseObj.ErrorDetail = e.getMessage();
                responseObjList.add(responseObj);
            }                                      
            return responseObjList;            
        }
        /*****************************************************/         
        public PageReference exportWSDL(){        
            PageReference pg = new PageReference(Label.UMPQUA_API_Import_Export_WSDL);        
            pg.setRedirect(false);         
            return pg;
        }
        public PageReference importWSDL(){
            PageReference pg = new PageReference(Label.UMPQUA_API_Import_Export_WSDL);        
            pg.setRedirect(false);         
            return pg;
        }
        public PageReference loginWSDL(){        
            PageReference pg = new PageReference(Label.UMPQUA_API_Login_WSDL);
            pg.setRedirect(false);         
            return pg;
        }
        /************** Export to Excel Methods **************/
        public PageReference accountExcel(){       
            if(days == 60){
                accList = [SELECT name,Phone,Industry,BillingStreet,BillingCity,NumberOfEmployees,Fax,CreatedDate,Ownership,type,Website,BillingState,BillingPostalCode,BillingCountry,Owner.name FROM Account where CreatedDate = LAST_N_DAYS :60 ];            
            }else{        
                accList = [SELECT name,Phone,Industry,BillingStreet,BillingCity,type,NumberOfEmployees,Fax,CreatedDate,Ownership,Website,BillingState,BillingPostalCode,BillingCountry,Owner.name FROM Account where CreatedDate = LAST_N_DAYS :30];            
            }        
            PageReference pg = new PageReference('apex/Communities_AccountExcel');       
            pg =  Page.Communities_AccountExcel;
            pg.setRedirect(false);         
            return pg;                   
        }
        public PageReference contactExcel(){
            if(days == 60){
                conList = [SELECT name,AccountId,Phone,Email,MailingStreet,MailingState,MailingCity,MailingPostalCode,MailingCountry,Title FROM Contact where CreatedDate = LAST_N_DAYS :60 ];
            }else{
                conList = [SELECT name,AccountId,Phone,Email,MailingStreet,MailingState,MailingCity,MailingPostalCode,MailingCountry,Title  FROM Contact where CreatedDate = LAST_N_DAYS :30 ];
            }
            PageReference pg = new PageReference('apex/Communities_ContactExcel');       
            pg =  Page.Communities_ContactExcel;
            pg.setRedirect(false);         
            return pg;              
        }
        public PageReference leadExcel(){        
            if(days == 60){
                leadList = [SELECT name,Phone,Industry,LeadSource,Company,Email,Status,Owner.name from Lead where CreatedDate = LAST_N_DAYS :60 and isConverted = false];            
            }else{
                leadList = [SELECT name,Phone,Industry,LeadSource,Company,Email,Status,Owner.name from Lead where CreatedDate = LAST_N_DAYS :30 and isConverted = false];
            }
            PageReference pg = new PageReference('apex/Communities_LeadExcel');       
            pg =  Page.Communities_LeadExcel;
            pg.setRedirect(false);         
            return pg;              
        }
        public PageReference oppExcel(){
            if(days == 60){
                oppList = [SELECT name,AccountId,StageName,CloseDate,Description,Amount,Owner.name FROM Opportunity where CreatedDate = LAST_N_DAYS :60];
            }else{
                oppList = [SELECT name,AccountId,StageName,CloseDate,Description,Amount,Owner.name FROM Opportunity where CreatedDate = LAST_N_DAYS :30];
            }
            PageReference pg = new PageReference('apex/Communities_OpportunityExcel');       
            pg =  Page.Communities_OpportunityExcel;
            pg.setRedirect(true);         
            return pg;              
        }          
              
        /************** Lead Routing Info Link ******************/
        /*public PageReference leadRoutingInfoLink(){                
            User usr = [Select id ,ContactId from User where id = :UserInfo.getUserId()];        
            if(usr.ContactId != Null){
                Contact con = [select accountId from Contact where id =:usr.ContactId];        
                Partner__c partnerObj = [select Lead_Routing_Info_Link__c from Partner__c where Partner_Account__c = :con.AccountId];            
                if(partnerObj.Lead_Routing_Info_Link__c != Null){                                                                              
                    PageReference pg = new PageReference(partnerObj.Lead_Routing_Info_Link__c);
                    pg.setRedirect(true);         
                    return pg; 
                }else{                                
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Lead Routing Info link is blank');
                    ApexPages.addMessage(myMsg);
                    return null;
                }
            }else{
                return null;
            }               
        }*/
        /***************************  Export Methods **************************/     
        Webservice static CommunitiesUI_Controller.ExportRecordsResponse exportAccounts(){
            // Response Instance
            CommunitiesUI_Controller.ExportRecordsResponse responseObj = new CommunitiesUI_Controller.ExportRecordsResponse();
            responseObj = Export('Account',60);
            return responseObj;
        }       
        Webservice static CommunitiesUI_Controller.ExportRecordsResponse exportContacts(){
            // Response Instance
            CommunitiesUI_Controller.ExportRecordsResponse responseObj = new CommunitiesUI_Controller.ExportRecordsResponse();
            responseObj = Export('Contact',60);
            return responseObj;
        }
        Webservice  static CommunitiesUI_Controller.ExportRecordsResponse exportLeads(){
            // Response Instance
            CommunitiesUI_Controller.ExportRecordsResponse responseObj = new CommunitiesUI_Controller.ExportRecordsResponse();
            responseObj = Export('Lead',60);
            return responseObj;
        }
        Webservice static CommunitiesUI_Controller.ExportRecordsResponse exportOpportunity(){
            // Response Instance
            CommunitiesUI_Controller.ExportRecordsResponse responseObj = new CommunitiesUI_Controller.ExportRecordsResponse();
            responseObj = Export('Opportunity',60);
            return responseObj;
        }
        public static CommunitiesUI_Controller.ExportRecordsResponse Export(String objectName,Integer days){        
            // Response Instance
            CommunitiesUI_Controller.ExportRecordsResponse responseObj = new CommunitiesUI_Controller.ExportRecordsResponse();
            String queryStr;
            if(objectName == 'Account'){
                queryStr = 'SELECT name,Phone,Industry,BillingStreet,BillingCity,type,BillingState,BillingPostalCode,BillingCountry,Owner.name FROM Account Where CreatedDate = LAST_N_DAYS :'+ days+' ';                   
            }
            else if(objectName == 'Contact'){
               queryStr = 'SELECT name,AccountId,Phone,Email,MailingStreet,MailingState,MailingCity,MailingPostalCode,MailingCountry,Title  FROM Contact Where CreatedDate = LAST_N_DAYS :'+ days+' ';
            }
            else if(objectName == 'Lead'){
                queryStr = 'SELECT name,Phone,Industry,Address,LeadSource,Company,Email,Status,Owner.name FROM Lead Where CreatedDate = LAST_N_DAYS :'+ days+' and isConverted = false ';
            }
            else if(objectName == 'Opportunity'){
                queryStr = 'SELECT name,AccountId,StageName,CloseDate,Description,Amount,Owner.name FROM Opportunity Where CreatedDate = LAST_N_DAYS :'+ days+' ';
            } 
            List<Sobject> sobjList = database.query(queryStr);
            if(sobjList.size()>0){
                responseObj.Status = 'Success'; 
                responseObj.Description = 'Last 60 days record of' + ' ' +objectName; 
                responseObj.objectRecord = sobjList; 
                responseObj.ErrorDetail = '';                          
            }
            else{
                responseObj.ErrorDetail = 'No records found for' + ' ' +objectName ;
            } 
            return responseObj;     
        }               
        global class ExportRecordsResponse{
            webService String Status;
            webService String Description;       
            webService String ErrorDetail;
            webService List<sObject> objectRecord;
        }
        global class ImportLeadResponse{                 
            webService String LeadIDNumber;
            webService String FirstName;
            webService String LastName;
            webService String Company; 
            webService String SFLeadID;                           
            webService String ErrorDetail;                                                      
        }
        global class AddressInfo{
            webService String Street;
            webService String City;
            webService String State;
            webService String Country;
            webService String PostalCode;
        }                
        global class LeadInsertion{        
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