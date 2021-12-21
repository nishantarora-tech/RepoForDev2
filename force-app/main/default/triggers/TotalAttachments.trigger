trigger TotalAttachments on Attachment (after insert,before update,after delete) {
    Set<Id> contractIds = new Set<Id>();
    Integer attachCount = 0;
    Id cId;
    for(Attachment att: Trigger.isDelete? Trigger.Old : Trigger.new){        
        cId = att.ParentId;
    }        
    Contract c = [Select id,Description,(Select id from Attachments) from Contract where Id=:cId ];
    
    Map<Id,List<Attachment>> attachMap = new Map<Id,List<Attachment>>();
    for(Attachment att: c.Attachments){
        attachCount++;        
    }  
    if(c.Description != Null){
        c.Total_Attachments__c = attachCount; 
        update c;
    }
}