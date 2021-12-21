trigger totalContentVersionOnContract1 on ContentVersion (after insert,after update) {
	Integer attachCount = 0;    
    Set<Id> contractIds = new Set<Id>();
    for(ContentVersion con : Trigger.new){
        //contentIds.add(con.id);
        contractIds.add(con.Contract__c);
    }
    List<Contract> contractList = [select id,Description,Total_Content_Version_on_Contract__c from Contract where Id In: contractIds];
    Map<Id,Id> contractMap = new  Map<Id,Id>();
    for(Contract cont:contractList){
        contractMap.put(cont.id,cont.id);
    }
    List<ContentVersion> contVer = [Select id from ContentVersion where Contract__c In: contractMap.keySet()];
    for(ContentVersion att: contVer){
       attachCount++; 
    }
    for(Contract con : contractList){
        if(con.Description != null)
            con.Total_Content_Version_on_Contract__c = attachCount;
        else
            con.Total_Content_Version_on_Contract__c = 0; 
    } 
    update contractList;
}