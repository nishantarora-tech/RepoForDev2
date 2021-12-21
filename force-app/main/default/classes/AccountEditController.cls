public class AccountEditController {
    public Account acc{get;set;}
    public Account oldAcc {get;set;}   
    public String strCaseIds{get;set;}
    public Boolean flag {get;set;}
    public List<Case> insertCaseList = new List<Case>();            
    public AccountEditController(ApexPages.StandardController controller) {        
        acc = new Account();
        oldAcc = new Account();
        if(ApexPages.currentPage().getParameters().get('id') != null){
            acc = [SELECT id,Chain_Code__c,Phone,DBA__c,Legal_Name__c,BillingStreet,BillingState,BillingCity,BillingCountry,BillingPostalCode,
            ShippingStreet,ShippingState,ShippingCity,ShippingCountry,ShippingPostalCode,Federal_Tax_ID__c from Account where Id =: ApexPages.currentPage().getParameters().get('id')];         
         }
        oldAcc = acc;       
        strCaseIds = '';   
        flag = false;            
    }       
    public void save(){                         
        oldAcc = [Select id,name,Federal_Tax_ID__c,Legal_Name__c from Account where Id = :acc.id]; 
        List<Case> caseList = [Select id,Description,AccountId from Case where AccountId=:oldAcc.id and Status = 'In Progress'];        
        System.debug('caseList-----'+caseList);
        Map<String,Case> caseMap = new Map<String,Case>();        
        for(Case cs: caseList){                                  
           caseMap.put(cs.Description,cs);                 
        }
        system.debug('caseMap---'+caseMap);       
        for(Schema.FieldSetMember f : SObjectType.Account.FieldSets.Approval_Required.getFields()) {                          
             if(string.valueOf(acc.get(f.getFieldPath())) != string.valueOf(oldAcc.get(f.getFieldPath()))){                                                                                                   
                 if(caseMap.size()>0 && caseMap.get(string.valueOf(f.label)) != null){
                     if(caseMap.get(string.valueOf(f.label)).Description.contains('Federal') || caseMap.get(string.valueOf(f.label)).Description.contains('Legal')){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Record Locked'));
                         flag = true;
                     }
                 }else{
                     insertCaseList.add(createNewCase(string.valueOf(oldacc.get(f.getFieldPath())),string.valueOf(acc.get(f.getFieldPath())),oldAcc.id,string.valueOf(f.label)));                                      
                 }                 
                 if(string.valueOf(f.label).contains('Federal')){
                     acc.Federal_Tax_Id__c = null;
                 }else if(string.valueOf(f.label).contains('Legal')){
                     acc.Legal_Name__c = null; 
                 }                               
             }              
        }
        if(insertCaseList.size()>0){               
            insert insertCaseList;
        }
        if(!insertCaseList.isEmpty()){
            for(case caseId : insertCaseList){
                Id NewCaseId = caseId.id;
                if(strCaseIds == ''){
                    strCaseIds = String.valueOf(NewCaseId);
                }
                else{
                    strCaseIds = strCaseIds +','+String.valueOf(NewCaseId);
                }
            }     
        } 
        try{
            List<account> updateAccountList = new List<Account>(); 
            updateAccountList.add(acc);
            Update updateAccountList;
             
        }Catch(Exception e){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.error,'Message'+e.getMessage()+'Line'));
        }                             
    }
    public Case createNewCase(String oldValue,String newValue,Id accountId,string fieldName){
        RecordType rt = [select Id from RecordType where SobjectType = 'Case' and Name = 'Field Approval Rejection' limit 1]; 
        Case csObj = new Case(); 
        csObj.recordTypeId = rt.id;
        csObj.New_Value__c = newValue;
        csObj.Description =  fieldName;
        csObj.Old_Value__c = oldValue;
        csObj.Priority = 'High';
        csObj.AccountId = accountId;
        csObj.Status = 'In Progress';
        return csObj;
    }
}