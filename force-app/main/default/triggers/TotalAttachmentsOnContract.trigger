trigger TotalAttachmentsOnContract on Contract (before Update) {
    Integer attachCount = 0;
    Set<Id> contractIds = new Set<Id>();
    for(Contract con : Trigger.new){
        contractIds.add(con.id);
    }
    Contract c = [select id,Description,(Select id from Attachments) from Contract where Id In: contractIds];
    for(Attachment att: c.Attachments){
       attachCount++; 
    }
    for(Contract con : Trigger.new){
        if(con.Description != null)
            con.Total_Attachments__c = attachCount;
        else
            con.Total_Attachments__c = 0; 
    }
}