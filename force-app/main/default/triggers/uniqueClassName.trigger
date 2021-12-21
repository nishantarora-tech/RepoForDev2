trigger uniqueClassName on Class__c (before insert,before update) {
    Set<String> clsName = new Set<String>();
    List<Class__c> clsList =[select name from Class__c];
    for(Class__c clsObj : clsList ){
         clsName.add(clsObj.name);
    }
    for(Class__c clsObj: Trigger.new){
        if(clsName.contains(clsObj.name)){
            clsObj.addError('Class Name already exist');
        }
    }
}