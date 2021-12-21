trigger SetOpportunityName on Opportunity (before insert) {

  Set<Id> AccountIds = new Set<Id>();
  for (Opportunity op : Trigger.new) {   
       accountIds.add(op.AccountId);
    }
  Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Name FROM Account WHERE Id IN :accountIds]);
  for (Opportunity op : Trigger.new) {

      // add the account name
      op.Name= accountMap.get(op.AccountId).Name + Date.Today().Year();
      }
}