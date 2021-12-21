public class EncryptionController {
    public String selectedObj{get;set;}
    public List<FieldWrapper> lstFieldName{get;set;}
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    //public List<String> lstSelectedFields = new List<String>();
    Blob cryptoKey = Blob.valueOf('380db410e8b11fa9');
    String query;
    public EncryptionController(){
        lstFieldName = new List<FieldWrapper>();
    }
    public List<SelectOption> getName(){
        List<Schema.SObjectType> gd = schemaMap.Values();     
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('None','None'));       
        for(Schema.SObjectType objTyp : gd){
            if(!objTyp.getDescribe().isCustom() && objTyp.getDescribe().isSearchable() ){
                options.add(new SelectOption(objTyp.getDescribe().getLabel(),objTyp.getDescribe().getLabel()));
            }
        }
        return options;
    }
    public void showFields(){
        Map<String,Schema.SObjectField> fieldMap = schemaMap.get(selectedObj).getDescribe().fields.getMap();
        system.debug('fieldMap---'+fieldMap);
        for(Schema.SObjectField sfield : fieldMap.Values()){
            schema.describeFieldResult dfield = sfield.getDescribe();
            Schema.DisplayType fieldDataType = fieldMap.get(dfield.getname()).getDescribe().getType();            
            if(fieldDataType == Schema.DisplayType.String){                
                FieldWrapper wrpObj = new FieldWrapper();
                wrpObj.fieldName = dfield.getname();                
                lstFieldName.add(wrpObj);
            }
        }
        system.debug('lstFieldName---'+lstFieldName);
    }
    public PageReference encryptSelectedFields(){ 
        String commaSepratedFields = '';        
            for(FieldWrapper fieldWrpObj : lstFieldName){
            if(fieldWrpObj.selected == true){
                /*Blob data = Blob.valueOf(fieldWrpObj.fieldName);
                Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey , data );
                String b64Data = EncodingUtil.base64Encode(encryptedData);
                fieldWrpObj.fieldName = b64Data;*/
                //lstSelectedFields.add(fieldWrpObj.fieldName);
                if(commaSepratedFields == null || commaSepratedFields == ''){
                    commaSepratedFields = fieldWrpObj.fieldName;
                }else{
                    commaSepratedFields = commaSepratedFields + ', ' + fieldWrpObj.fieldName;
                }
            }         
        }
        query = 'select ' + commaSepratedFields + ' from ' + selectedObj + ' Limit 2';
        List<Sobject> sobjList = Database.query(query);
        system.debug('commaSepratedFields---'+commaSepratedFields);
        system.debug('sobjList---'+sobjList);
        List<Sobject> sObjList2 = new List<Sobject>();
        for(Sobject obj : sobjList){
            /*Blob data = Blob.valueOf(Obj.name);
            Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey , data );
            String b64Data = EncodingUtil.base64Encode(encryptedData);
            Obj.name = b64Data;
            sObjList2.add(obj);*/
        }
        update sObjList2;
        return null; 
    }
    public class FieldWrapper{
        public String fieldName {get; set;}
        public Boolean selected{get;set;}
    }  
}