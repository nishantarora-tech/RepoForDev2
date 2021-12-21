public class ApplicationConfigurationController{
    public String objectSelection {get;set;}        
    public List<Schema.SObjectType> schemaObject {get;set;}    
    public objectFieldsWrapper wrpObjectFields {get;set;}   
    public List<objectFieldsWrapper> wrpObjectFieldsList {get;set;} 
    Map<String,Schema.SObjectField> mapFields = new Map<String,Schema.SObjectField>();
    public ApplicationConfigurationController(){               
        //wrpObjectFieldsList = new List<objectFieldsWrapper>();                                        
    }
    public pageReference objectFields(){                            
        if(objectSelection != Null){  
            wrpObjectFieldsList = new List<objectFieldsWrapper>();                                             
            Map <String,Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            mapFields = schemaMap.get(objectSelection).getDescribe().fields.getMap();                                     
            for(Schema.sObjectField field : mapFields.values()){
                wrpObjectFields = new objectFieldsWrapper();
                schema.describeFieldResult dField = field.getDescribe();                                                           
                wrpObjectFields.APiName = dField.getName(); 
                wrpObjectFields.fieldLabel = dField.getLabel();
                wrpObjectFields.fieldType = String.valueOf(dField.getType());
                wrpObjectFields.fieldLength = dField.getLength();                                   
                wrpObjectFieldsList.add(wrpObjectFields);                                         
            }                                                                                                                                                                                                                             
         }                                                                                                                   
        return null;
    }
    public pageReference fieldButton(){                
        for(objectFieldsWrapper fieldWrp : wrpObjectFieldsList){
            if(fieldWrp.selected == true){
                System.debug('fieldWrp---'+fieldWrp);
                //fieldWrp.APiName = '*********';            
                sObject obj = Schema.getGlobalDescribe().get(objectSelection).newSObject();                                              
                System.debug('obj---'+obj);    
                                                          
                /*Blob cryptoKey = Crypto.generateAesKey(256);                
                Blob data = Blob.valueOf(fieldWrp.APiName);
                string name = fieldWrp.APiName;
                Blob encryptedData = Crypto.encryptWithManagedIV('AES256',cryptoKey,data);
                String b64Data = EncodingUtil.base64Encode(encryptedData);
                fieldWrp.APiName = b64Data;   
                //Blob data = EncodingUtil.base64Decode(fieldWrp.APiName);
                Blob decryptedData = Crypto.decryptWithManagedIV('AES256', cryptoKey , data);
                String dryptData = decryptedData.toString();
                System.debug('Printing dryptData '+dryptData);              
                acc.Name = dryptData;   */                                                                                          
            }            
        }                
        if(objectSelection != 'Article1__kav' && objectSelection != Null){
            String queryStr='select id from ' +objectSelection;
            List<sobject> objList = Database.query(queryStr);
            system.debug('objList-----'+objList);
        }        
        //pageReference pg = new PageReference('/'+obj.id);   
        //pg.setRedirect(true);    
        return null;
    }   
    public List<SelectOption> getObjectsOptions() {                
        schemaObject = processInstance.TargetObjectId.getDescribe().getReferenceTo();
        List<SelectOption> objectOptions= new List<SelectOption>();
        objectOptions.add(new SelectOption('','--None--'));
         for(Schema.SObjectType sObjType: schemaObject){
             if((sObjType.getDescribe().isSearchable())){                
                 objectOptions.add(new SelectOption(sObjType.getDescribe().getName(),sObjType.getDescribe().getLabel()));
             }            
        }      
        return objectOptions;
    }
    public class objectFieldsWrapper{
        public Boolean selected{get;set;}        
        public string APiName {get;set;} 
        public string fieldLabel{get;set;} 
        public string fieldType{get;set;} 
        public integer fieldLength{get;set;}
        public objectFieldsWrapper(){
            selected = false;
        }                                               
    }  
       
}