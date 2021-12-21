trigger primaryContact on Opportunity (before insert,before update) {
    Set<Id> accIds = new Set<Id>();
    Map<Id,Id> accIdToConId = new Map<Id,Id>();
    for(Opportunity opp : Trigger.new){
        if(Trigger.oldMap==null || (Trigger.oldMap!=null && Trigger.oldMap.get(opp.id).AccountId!=opp.AccountId)){
            accIds.add(opp.AccountId);
        }
    }
    if(!accIds.isEmpty()){
        List<Contact> conList = [Select accountId from Contact where AccountId In : accIds and Primary__c=true];
        for(Contact con : conList){
            accIdToConId.put(con.accountId,con.Id);
        }
        for(Opportunity opp : Trigger.new){
            if(accIdToConId!=null && accIdToConId.containsKey(opp.AccountId) && accIdToConId.get(opp.AccountId)!=null){
                opp.Contact__c = accIdToConId.get(opp.AccountId);
            }else{
                opp.Contact__c =  null;
            }
        }
    }
    
}