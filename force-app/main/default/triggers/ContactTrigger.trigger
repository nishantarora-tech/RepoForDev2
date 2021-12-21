trigger ContactTrigger on Contact (after insert,after update) {
    Set<id> conIdSet=new Set<id>();
    for(Contact con:trigger.new){
        if(trigger.oldMap == null || (trigger.oldMap.get(con.Id) != con)){
            conIdSet.add(con.id);
        }
    }
    if(conIdSet.size() > 0){
        //callWebserviceClass.getConList(accIdSet);
    }
}