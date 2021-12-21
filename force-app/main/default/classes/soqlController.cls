public class soqlController {    
    public String strQuery{get;set;}               
    public List<Schema.SObjectField> fieldsSchemaList{get;set;}     
    public integer count{get;set;}            
    public List<SObject> sObjList{get;set;}        
    public soqlController(){
        count = 0;                
        fieldsSchemaList = new  List<Schema.SObjectField>();            
    }    
    public void go(){        
        try{
            if(!String.isEmpty(strQuery)){
                Map<String,String> fieldStrMap = new Map<String,String>();
                List<String> fieldList = new List<String>();
                String strObjName  = strQuery.substringAfter('from').substring(1).toUpperCase();                                
                Schema.SObjectType objectName = Schema.getGlobalDescribe().get(strObjName);                
                system.debug('objectName----'+objectName);                
                fieldList = strQuery.toLowerCase().substringBetween('select','from').split(',');                                               
                Map<String, Schema.SObjectField> fieldMap = objectName.getDescribe().fields.getMap();
                for(String strObj : fieldList){
                    fieldStrMap.put(strObj,strObj);
                }                  
                for(Schema.SObjectField f : fieldMap.values()){                        
                        //system.debug('fieldChk----'+fields.contains('name')); 
                        system.debug('outside----'+fieldStrMap); 
                        if(fieldStrMap.containsKey('name')){ 
                            system.debug('Inside----');                                               
                            fieldsSchemaList.add(f); 
                        }                                       
                }
                system.debug('fields(2)----'+fieldsSchemaList);                                    
            }                       
            sObjList = database.query(strQuery);            
            for(SObject sObj : sObjList){
                count++;
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Query is not appropriate. Please check the query')); 
        }
    }
}