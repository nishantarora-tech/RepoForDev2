trigger duplicateLead on Lead (before insert) {
    Set<String> name = new Set<String>();
    Map<String,Lead> leadMap = new Map<String,Lead>();    
    List<Lead> leadList = [select firstName,lastName from Lead];
    for(Lead lead1: leadList){        
        name.add(lead1.firstName);    
        name.add(lead1.lastName);    
    }
    for(Lead l : Trigger.new){
        if(name.contains(l.firstName) && name.contains(l.lastName)){
            l.addError('Record Already Exist');
        }                
    }
    
}