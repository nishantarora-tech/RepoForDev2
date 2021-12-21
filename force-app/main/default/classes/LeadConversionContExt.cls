public with sharing class LeadConversionContExt {
    
    public Lead leadObj {get;set;}
    public Lead leadName {get;set;}
    public Account accObj {get;set;}
    public string Accountname {get;set;}
    Id leadId;
    public Partner__c partnerObj {get;set;}
    
    public LeadConversionContExt(ApexPages.StandardController stdController) {
        //leadObj = (Lead)stdController.getRecord();        
        leadObj = new Lead();
        leadId = ApexPages.currentPage().getParameters().get('id');
        if(leadId != null){
           leadObj = [select name,firstName,lastName,company,ownerId,Account_Name__c,status from Lead where id=:leadId ];
           //leadObj.Account_Name__c = 'Create New Account:' + leadObj.company;
           Accountname = 'Create New Account:' + leadObj.Company; 
           leadObj.Company += '-';           
           leadObj.status = 'Closed - Converted';
        }
    }         
    public PageReference convertLead() {                                                   
       Account acc = new Account();
       acc.name =  leadObj.Company.removeEnd('-'); 
       insert acc;
       
       Contact con = new Contact();
       con.AccountId = acc.id;
       con.firstname = leadObj.firstName;
       con.lastName = leadObj.LastName;
       insert con;
       
       Opportunity opp = new Opportunity();
       opp.name = leadObj.Company;
       opp.AccountId = acc.id;
       opp.stageName = 'Prospecting';
       opp.closeDate = date.valueOf(system.now().addMonths(1));
       insert opp;         
       PageReference pageRef = new PageReference('/'+acc.id);
       pageRef.setRedirect(true);               
       return pageRef;                                                     
    }
    public PageReference cancel(){
       PageReference pageRef = new PageReference('/'+leadObj.id);
       pageRef.setRedirect(true);               
       return pageRef;     
    }
}