trigger contactCreation on Account (after insert,after update){
    Map<ID,Account> accountMap = new Map<ID,Account>();
    List<Contact> conList = new List<Contact>();
    for(Account acc : Trigger.new){
        if(acc.type == 'Prospect'){
           accountMap.put(acc.id,acc);     
        }
    }
    if(accountMap != null){
        for(Account accountObj : accountMap.values()){
            Contact con = new Contact();
            con.AccountID = accountObj.id;
            con.lastName = accountObj.type;
            conList.add(con);
        }
        insert conList;
    }

}