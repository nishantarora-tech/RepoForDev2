trigger UpdateAccountOwner on Account (before insert) {
    
    Set<ID> AccountIds= new Set<ID>();
    List<Account> lstAccount = new List<Account>();
    Map<Id,Id> idMap= new Map<Id,Id>();
    for(Account acc: Trigger.new){
        AccountIds.add(acc.ParentID);
    }   
    List<Account> accList=[select ownerId,ParentId from Account where id in :AccountIds];
    for(Account acc1:accList){
        idMap.put(acc1.id,acc1.ownerId);
    }
    for(Account accObj:Trigger.new){
        accObj.ownerId=idMap.get(accObj.ParentID);
    }
}