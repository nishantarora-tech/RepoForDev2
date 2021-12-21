trigger updateAccountFieldsAfterApproval on Case (before update) {
    Map<Id,Case> caseMap = new Map<Id,Case>();
    List<Account> accountList = new List<Account>();
    for(Case cs:Trigger.new){                   
        caseMap.put(cs.AccountId,cs);        
    }
    if(caseMap != null){
        List<Account> accList = [select id,federal_tax_Id__c from Account where Id In :caseMap.keyset()];
        for(Account acc:accList){
            if(caseMap.containsKey(acc.id)){
                if(caseMap.get(acc.id).Status =='Approved'){
                    if(caseMap.get(acc.id).Description.contains('Federal')){
                        acc.Federal_Tax_Id__c  = caseMap.get(acc.id).New_value__c;
                    }else{                    
                        acc.Legal_Name__c = caseMap.get(acc.id).New_value__c;
                    }
                 }
                 else if(caseMap.get(acc.id).Status =='Rejected'){
                     if(caseMap.get(acc.id).Description.contains('Federal')){
                         acc.Federal_Tax_Id__c  = caseMap.get(acc.id).Old_Value__c;
                     }else{    
                         acc.Legal_Name__c = caseMap.get(acc.id).Old_Value__c;
                     }
                 }
                 accountList.add(acc);
            }
        }
    }
    if(accountList.size()>0){
        update accountList; 
    }
}