trigger OwnerManager on Opportunity (before insert,before update) {
    Set<String> oppId = new Set<String>(); 
    Map<Id,User> userMap = new Map<Id,User>();    
    for(Opportunity opp : Trigger.new){      
      oppId.add(opp.OwnerId);   
    }        
    List<User> usrList = [select Manager.name from user where Id In :oppId];
    for(User usr:usrList){
      userMap.put(usr.Id,usr);  
    }
    for(Opportunity opp : Trigger.new){
        opp.Owner_s_Manager__c = userMap.get(opp.ownerId).Manager.Name;               
    }         
}