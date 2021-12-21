trigger contactCreationThroughRestClass on Contact (after insert) {
    Set<Id> accIds = new Set<Id>();
    for(Contact con:Trigger.new){
        if(con.AccountId != null){
            accIds.add(con.AccountId);
        }
    }
    Map<Id,Account> accMap = new Map<Id,Account>([Select name from Account where id In: accIds]);
    if(accMap.size()>0){
        for(Contact con:Trigger.new){
            SendAccountAndContactUsingRESTAPI.createAccountAndContact(accMap.get(con.AccountId).name,con.firstName,con.lastName);
        }
    }
}