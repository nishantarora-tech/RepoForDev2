global class stationAssignment implements Database.Batchable<sObject>, Database.Stateful{
     
    global integer numberofDirectCustomers = 0;
    global  stationAssignment(Map<id, User> assignStations){
        
    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        String soqlQuery = 'SELECT Name, AccountNumber, Type From Account';
        return Database.getQueryLocator(soqlQuery);
    }
     
    global void execute(Database.BatchableContext bc, List<Account> scope){
         
        for (Account acc : scope){
            if(acc.Type.equals('Customer - Direct')){
                numberofDirectCustomers++;
            }
        }
    }
     
    global void finish(Database.BatchableContext bc){
         
    }
}