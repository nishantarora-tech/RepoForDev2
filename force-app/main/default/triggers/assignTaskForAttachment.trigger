trigger assignTaskForAttachment on Attachment (before insert) {
    Set<Id> accIds = new Set<Id>();
    Map<Id,Id> mapAccountIdToContact = new Map<Id,Id>();
    for(Attachment attObj : trigger.new){        
        if(string.valueOf(attObj.ParentId).startsWith('001')){
        	accIds.add(attObj.ParentId);            
        }
    }
    if(!accIds.isEmpty()){
        List<Task> taskObjList = new List<Task>();
    	List<Contact> conList = [Select AccountId,id from Contact where AccountId In:accIds];
        if(conList.size()>0){
            for(Contact con : conList){
                mapAccountIdToContact.put(con.AccountId,con.Id);
            }
            for(Attachment attObj : trigger.new){
                Task taskObj = new Task();                
                taskObj.whoId = mapAccountIdToContact.get(attObj.ParentId);
                taskObj.Subject = attObj.Name;
                taskObjList.add(taskObj);
            }
            if(taskObjList.size()>0){
                insert taskObjList;
            }
        }
    }
}