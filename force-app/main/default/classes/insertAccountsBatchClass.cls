global class insertAccountsBatchClass implements database.batchable <sObject>,Schedulable{
    global final String Query;
    /*global insertAccountsBatchClass(String q){
        Query=q;
    }*/
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id from Account');
    }
    global void execute(Database.BatchableContext BC,List<Account> scope){
        List<Account> lstAccount = new list<Account>();
        for(Account acc : scope){
            acc.name = acc.Name + ' ' +'Updated';            
        }
        update scope;        
    } 
    global void execute(SchedulableContext  sc){
        insertAccountsBatchClass obj = new insertAccountsBatchClass();
        System.schedule('Scheduled Job 1', '0 2 * * * ?', obj); 
    }  
    global void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'aroranishu7@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Batch Job is done');
        mail.setPlainTextBody('The batch Apex job processed ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    }     
}