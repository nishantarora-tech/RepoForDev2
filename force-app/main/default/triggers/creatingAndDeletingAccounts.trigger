trigger creatingAndDeletingAccounts on Account (after insert) {    
    Set<Id> accountId = new Set<Id>();
    for(Account acc :Trigger.new){
        accountId.add(acc.id);
        SendAccountUsingRESTAPI.createAccount(acc.name,acc.id);
    }  
    //List<Account> accList = [select id,name,(select id,name from Contacts) from Account where Id In:accountId];         
}