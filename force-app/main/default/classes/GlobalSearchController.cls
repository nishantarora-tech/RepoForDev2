Public with sharing class GlobalSearchController{
   public List<Schema.SObjectType> schemaObject{get;set;}
   public string searchText {get;set;}
   String[] selectedObj = new String[]{};
   public list<searchResultRow> searchResults {get;set;} 
   public Map <String, String> labelToAPIName = new Map <String, String> ();       
   public String[] getSelectedObj() {
            return selectedObj;
        }
    public void setSelectedObj(String[] selectedObj) {
        this.selectedObj = selectedObj;
    }
    //Constructor
    public GlobalSearchController(){
       searchText='Search...';
         searchResults = new list<searchResultRow>();
         searchResultsMethod();
    }    
   public List<SelectOption> getItems() {                
        schemaObject= ProcessInstance.TargetObjectId.getDescribe().getReferenceTo();    
        List<SelectOption> options = new List<SelectOption>();            
        for(Schema.SObjectType sObjType: schemaObject){
            if((sObjType.getDescribe().isSearchable())){ 
                Map<string,string> lstFieldName=new Map<string,string>();
                Map <String, Schema.SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();        
        for(Schema.SObjectField sfield : fieldMap.Values()){
            schema.describefieldresult dfield = sfield.getDescribe();
            lstFieldName.put(dfield.getName(),dfield.getName());
        }
        if(lstFieldName.containsKey('Name')){                          
             options.add(new SelectOption(sObjType.getDescribe().getLabel(),sObjType.getDescribe().getLabel()));
             labelToAPIName.put(sObjType.getDescribe().getLabel(), sObjType.getDescribe().getName());
             }
           }
         }
          return options;          
     }      
    public list<list<sObject>> soslResults {
        get {                 
           if(searchText != null && searchText.length()>1 && (!selectedObj.isEmpty())) {
                String QueryString;                                   
                QueryString =  'FIND \''+searchText+'\' IN ALL FIELDS RETURNING ';            
                for(string sObj: selectedObj){
                    String selectedObjAPIname = labelToAPIName.get(sObj);
                    QueryString =  QueryString+selectedObjAPIname+'(Name),';
                }           
                 integer len=QueryString.length() - 1;
                 string quryString=QueryString.substring(0,len);
                 soslResults = search.query(quryString);                   
                } 
            else if (searchText.length()>1  && selectedObj.isEmpty()){
                String QueryString;                                   
                QueryString =  'FIND \''+searchText+'\' IN ALL FIELDS RETURNING ACCOUNT(Name),ASSET(Name),Contact(Name),Opportunity(Name),Contract(Name),Lead(Name)';
                soslResults=search.query(QueryString);
             }                            
                return soslResults;
            }
        set;
    } 
    //Wrapper Class              
    public class searchResultRow{
        public string sObjectTypeName {get;set;}
        public sObject record {get;set;} 
        //Constructor       
        public searchResultRow(sObject pObject) {                       
            record = pObject;
            sObjectTypeName = pObject.getSObjectType().getDescribe().getLabel();
        }
       }
       //Search Method                 
     public void searchResultsMethod(){        
             searchResults = new list<searchResultRow>();                                                                                              
             if(soslResults != null && searchText.length()>0) {
                //Loop through the list of list of sObjects from our sosl query
                for(list<sObject> objectList : soslResults) {
                    for(sObject obj : objectList) {
                        searchResults.add(new searchResultRow(obj));
                    }
                }                
            }
            if(searchText=='Search...'){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Info,'Please enter string');
                ApexPages.addMessage(myMsg);
             }      
            if(searchText.length()<1 && !selectedObj.isEmpty()){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Enter search term ');
                ApexPages.addMessage(myMsg);
            }
            else if(searchText.length()<1){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Your Search term must have two or more characters');
                 ApexPages.addMessage(myMsg);
             }                                                                                                                                             
     }

}