trigger UpdateAccountAmountFromOpportunity on Opportunity (after insert,after update) {

    Set<Id> accountIds = new Set<Id>();    
    for(Opportunity opp : Trigger.New){
        if(opp.StageName == 'Closed Won'){
            accountIds.add(opp.AccountId);
        }
     }              
     List<Account> accList = [SELECT name,Average_Opportunity_Amount__c from Account where Id IN : accountIds];   
     List<AggregateResult> aggregateList = [SELECT Avg(Amount)average from Opportunity where AccountId IN : accountIds];     
     Integer average;
     for(AggregateResult ar : aggregateList){
         average = Integer.valueOf(ar.get('average'));                               
     }
     for(Account acc : accList){  
          acc.Average_Opportunity_Amount__c = average;                  
     }                             
     update accList;     
}