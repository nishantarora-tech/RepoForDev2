Public class Global_Search{
   public List<Schema.SObjectType> sS{get;set;}
   public string searchText {get;set;}
   String[] selectedObj = new String[]{};
   public Map <String, String> labelToAPIName = new Map <String, String> ();
      
    public Global_Search(){
    searchText='Search..';  
    }  
    public String[] getSelectedObj() {
            return selectedObj;
        }
    public void setSelectedObj(String[] selectedObj) {
        this.selectedObj = selectedObj;
    }
   public List<SelectOption> getItems() {        
        sS= ProcessInstance.TargetObjectId.getDescribe().getReferenceTo();    
        List<SelectOption> options = new List<SelectOption>(); 
           
        for(Schema.SObjectType sObjType: sS){
        if((sObjType.getDescribe().isSearchable())){ 
        Map<string,string> lstFieldName=new Map<string,string>();
        Map <String, Schema.SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();
        //string check='Name';
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
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
            
            if(searchText != null && searchText != '' && (!selectedObj.isEmpty())) {
            String QueryString =  'FIND \''+searchText+'\' IN ALL FIELDS RETURNING ';
            for(string sObj: selectedObj){
            String selectedObjAPIname = labelToAPIName.get(sObj);
            QueryString =  QueryString+selectedObjAPIname+'(Name),';
           }
            integer len=QueryString.length() - 1;
            string quryString=QueryString.substring(0,len);
            soslResults = search.query(quryString);
            }                                          
            return soslResults;
        }
        set;
    }
    
    public class searchResultRow{
        public string sObjectTypeName {get;set;}
        public sObject record {get;set;}
        
        public searchResultRow(sObject pObject) {            
           
            record = pObject;
            sObjectTypeName = pObject.getSObjectType().getDescribe().getLabel();
        }
       }       
    public list<searchResultRow> searchResults {
        get {
            searchResults = new list<searchResultRow>();
            if(soslResults != null) {
                //Loop through the list of list of sObjects from our sosl query
                for(list<sObject> objectList : soslResults) {
                    for(sObject obj : objectList) {
                        searchResults.add(
                            new searchResultRow(obj)
                        );
                        
                    }
                }   
            }
            
            return searchResults;
            
        }
        set;
    }

}