global with sharing class ExportingRecords{        
    public List<Account> accList{get;set;}
    public List<Contact> conList{get;set;}
    public List<Lead> leadList{get;set;}
    public List<Opportunity> oppList{get;set;}
    public ExportingRecords(){                                
    }
    webService static List<ExportingRecords.importLeadResponse> importLead(List<ExportingRecords.LeadInsertion> LeadInsertionObj){        
        List<ExportingRecords.importLeadResponse> responseObjList = new List<ExportingRecords.importLeadResponse>();
        Map<Id,Lead> leadMap = new Map<Id,Lead>();                
        List<Lead> leadObjList = new List<Lead>();        
        for(ExportingRecords.LeadInsertion lead : LeadInsertionObj){
            Lead leadObj = new Lead();
            leadObj.firstName = lead.firstName;
            leadObj.lastName = lead.lastName;
            leadObj.company = lead.Company;        
            //upsert leadObj;
            leadObjList.add(leadObj);            
        }              
        insert leadObjList;        
        if(leadObjList.size()>0){            
            /*responseObj.Id = leadObj.Id;
            responseObj.firstName = leadObj.firstName;
            responseObj.lastName = leadObj.lastName;
            responseObj.company = leadObj.Company;*/ 
            for(Lead leadObject :leadObjList){
              leadMap.put(leadObject.id,leadObject);   
            }
            for(Lead leadOb :leadMap.values()){
                ExportingRecords.importLeadResponse responseObj = new ExportingRecords.importLeadResponse();
                responseObj.Id = leadOb.id;
                responseObj.firstName = leadOb.firstName;
                responseObj.lastName = leadOb.lastName;
                responseObj.company = leadOb.Company;
                responseObjList.add(responseObj);
            }                                   
        }else{           
            //responseObj.Status = 'Failure';                       
        }       
        return responseObjList;        
    } 
        
    public PageReference exportAccountWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKll/fNuqYpnXchO05gX07c44HVS8HLq2_oyZgbNRYIBO_aw');        
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference exportContactWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKlq/WxdIV6pvvaXD.S8LpO9rCNAuwDyjZRiE9JNMg8wopPM');        
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference exportLeadWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKlv/xM48QbIIgH3Ul1PaVcjt8wtMlnZ0s3aen2MIP2vRZFQ');        
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference exportOpportunityWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKm0/FqokhyRu93nVFexjguGsIf.SvkUYN1wqBlrFZbiEphQ');        
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference importWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKm5/1kzmJdeqmdiJdl98EHCsHJSqfgZVHXLHNBD7oDVY7SI');        
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference loginWSDL(){        
        PageReference pg = new PageReference('https://ap1.salesforce.com/sfc/p/90000000rm2s/a/90000000LKmA/c1yiGgj2XYDDjZi1WJIArFWdFcvkCotbtL2BbLWoiOU');
        pg.setRedirect(false);         
        return pg;
    }
    public PageReference accountExcel(){
        accList = [select name,owner.name,Type,RecordType.name,Phone,Fax,Website,CreatedDate,NumberOfEmployees,Ownership from Account where CreatedDate = THIS_MONTH];
        PageReference pg = new PageReference('Apex/Communities_AccountExcel');       
        pg =  Page.Communities_AccountExcel;
        pg.setRedirect(false);         
        return pg;             
    }
    public PageReference contactExcel(){
        conList = [select name,owner.name,Email,Fax,HomePhone,Department,MobilePhone,Title,Description,CreatedDate from Contact where CreatedDate = THIS_MONTH];
        PageReference pg = new PageReference('Apex/Communities_ContactExcel');       
        pg =  Page.Communities_ContactExcel;
        pg.setRedirect(false);         
        return pg;              
    }
    public PageReference leadExcel(){
        leadList = [select name,owner.name,LeadSource,Email,Fax,Phone,Company,Status,Title,CreatedDate  from Lead where CreatedDate = THIS_MONTH and isConverted = false ];
        PageReference pg = new PageReference('Apex/Communities_LeadExcel');       
        pg =  Page.Communities_LeadExcel;
        pg.setRedirect(false);         
        return pg;              
    }
    public PageReference oppExcel(){
        oppList = [select name,owner.name,StageName,Description,Probability,CloseDate,Type,Amount,RecordType.name,CreatedDate from Opportunity where CreatedDate = THIS_MONTH];
        PageReference pg = new PageReference('Apex/Communities_OpportunityExcel');       
        pg =  Page.Communities_OpportunityExcel;
        pg.setRedirect(false);         
        return pg;              
    }        
    public PageReference partnerRecord(){        
        PageReference pg = new PageReference('https://cs25.salesforce.com/a1Q1b00000097Cu');
        pg.setRedirect(false);         
        return pg; 
    }     
    Webservice static ExportingRecords.recordsResponse exportAccounts(){
        ExportingRecords.recordsResponse responseObj = new ExportingRecords.recordsResponse();
        responseObj = Export('Account',60);
        return responseObj;
    }
    Webservice static ExportingRecords.recordsResponse exportContacts(){
        ExportingRecords.recordsResponse responseObj = new ExportingRecords.recordsResponse();
        responseObj = Export('Contact',60);
        return responseObj;
    }
    Webservice  static ExportingRecords.recordsResponse exportLeads(){
        ExportingRecords.recordsResponse responseObj = new ExportingRecords.recordsResponse();
        responseObj = Export('Lead',60);
        return responseObj;
    }
    Webservice static ExportingRecords.recordsResponse exportOpportunity(){
        ExportingRecords.recordsResponse responseObj = new ExportingRecords.recordsResponse();
        responseObj = Export('Opportunity',60);
        return responseObj;
    }
    public static ExportingRecords.recordsResponse Export(String objectName,Integer days){
        // Instance of Wrapper class
        ExportingRecords.recordsResponse responseObj = new ExportingRecords.recordsResponse();
        String queryStr;
        if(objectName == 'Account'){
            queryStr = 'SELECT name,RecordType.Name,Description,NumberOfEmployees,Ownership,Type,Website,Owner.name,CreatedDate FROM Account Where CreatedDate = LAST_N_DAYS :'+ days+' ';                   
        }
        else if(objectName == 'Contact'){
           queryStr = 'SELECT name,Email,MobilePhone,Title,Description,LeadSource,Owner.name,CreatedDate FROM Contact Where CreatedDate = LAST_N_DAYS :'+ days+' ';
        }
        else if(objectName == 'Lead'){
            queryStr = 'SELECT name,RecordType.Name,Company,Email,Description,Status,Title,Owner.name,CreatedDate FROM Lead Where CreatedDate = LAST_N_DAYS :'+ days+' ';
        }
        else if(objectName == 'Opportunity'){
            queryStr = 'SELECT name,RecordType.Name,StageName,CloseDate,Type,TotalOpportunityQuantity,Amount,LeadSource,Owner.name,CreatedDate FROM Opportunity Where CreatedDate = LAST_N_DAYS :'+ days+'';
        } 
        List<Sobject> sobjList = database.query(queryStr);
        if(sobjList.size()>0){
            responseObj.Status = 'Success'; 
            responseObj.Description = 'Current month record of' + ' ' +objectName; 
            responseObj.objectRecord = sobjList;                           
        }
        else{
            responseObj.ErrorDetail = 'No records found for' + ' ' +objectName ;
        } 
        return responseObj;     
    }
    global Class recordsResponse{
        webService String Status;
        webService String Description;
        webService String ErrorDetail;       
        webService List<sObject> objectRecord;
    }
    global class importLeadResponse{
        webService String Id;
        webService String firstName;
        webService String lastName;
        webService String Company;
    } 
    global Class LeadInsertion{        
        webService String firstName;
        webService String lastName;
        webService String Company;               
    }        
}