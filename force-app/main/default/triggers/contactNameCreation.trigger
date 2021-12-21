trigger contactNameCreation on Opportunity(before update) {
Set<Id> accountId = new Set<Id>();
Map<String,String> mapEmail = new Map<String,String>();
List<Opportunity> oppList = new List<Opportunity>();
List<String> emailStrList = new List<String>();
List<Contact> conList = new List<Contact>();
String emailStr;
    for(Opportunity op : Trigger.new){    
        if(op.Status__c == 'Approved'){
           if(op.Email__c != Null){
               emailStr = String.valueOf(op.Email__c).substringBetween('@','.');
               mapEmail.put(emailStr,op.name);               
               emailStrList.add(emailStr);
           }                                                    
        }
    }    
    List<Account> accList = [select name from Account where name In :emailStrList];
    if(accList.size()>0 && accList != Null){    
        for(Account acc : accList){        
            Contact con = new Contact();        
            con.AccountId = acc.id;               
            con.LastName = mapEmail.get((acc.name).toLowerCase());        
            conList.add(con);          
        } 
    }
    else if(emailStr != null){    
        Account acct = new Account();
        acct.name = emailStr;
        insert acct;
        Contact cont = new Contact();
        cont.LastName = emailStr;
        cont.AccountId = acct.id;
        insert cont;
    }  
    if(conList.size()>0){    
        insert conList;
    }
    
}