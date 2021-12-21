trigger notMoreThanOneOppOnAccount on Opportunity (before Insert) {
Set<ID> accountIds = new Set<ID>();
    for(Opportunity opp : Trigger.new){
        accountIds.add(opp.AccountId);
    }
    List<Account> accList = [select id,(select id from Opportunities) from Account where id In:accountIds];      
    Map<Id,List<Opportunity>> oppMap = new Map<Id,List<Opportunity>>(); 
    for(Account acc :  accList){
        oppMap.put(acc.id,acc.opportunities);
    }
    for(Opportunity opp : Trigger.new){
        if(oppMap.containsKey(opp.AccountId)){
            List<Opportunity> oppList= new List<Opportunity>(oppMap.get(opp.AccountId));
            if(oppList.size()>0){
               opp.addError('Can not create more than one opportunity on Account'); 
            }
        }
    }
}