trigger restrictToDeleteAccount on Account (before delete) {    
    Map<Id,Account> mapAccount = new Map<Id,Account>();
    List<Account> updateAccList = new List<Account>();    
    //Account accObj = new Account();
    List<Account> accList = new List<Account>();            
    for(Account acc : trigger.old) {                        
        Account acc1 = new Account();
        mapAccount.put(acc.id,acc);                                                   
        acc1.name = Trigger.oldMap.get(acc.id).name;       
        acc1.undelete__c = True;              
        updateAccList.add(acc1);                      
    }                                                
    if(updateAccList.size()>0){
        insert updateAccList;
    }                       
}