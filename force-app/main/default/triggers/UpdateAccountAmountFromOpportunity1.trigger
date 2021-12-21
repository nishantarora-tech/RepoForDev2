trigger UpdateAccountAmountFromOpportunity1 on Opportunity (before insert,after update,after delete) {

    List<Account> accList = new List<Account>();
    Set<Id> accountIds = new Set<Id>();       
    for(Opportunity opp : trigger.isDelete ? trigger.Old : trigger.new){
        //if(Trigger.oldMap.get(opp.Id).StageName == 'Closed Won'){
            accountIds.add(opp.AccountId);
        //}
     }                                        
     List<AggregateResult> aggregateList = [SELECT Avg(Amount)average,AccountId from Opportunity where AccountId IN : accountIds and  StageName  = 'Closed Won' group by AccountId ];                    
     for(AggregateResult ar : aggregateList){        
        Account acc = new Account();                          
        acc.id = String.valueOf(ar.get('AccountId'));       
        acc.Average_Opportunity_Amount__c = Integer.valueOf(ar.get('average'));                        
        accList.add(acc);              
     } 
     if(accList.size()>0 && accList!= Null){
       update accList; 
    }       
}