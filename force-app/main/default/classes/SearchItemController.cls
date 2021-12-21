public class SearchItemController{
    public Map<String,Schema.SObjectType> schemaObject{get;set;}
    public String strSearchText {get;set;}
    String[] selectedObj = new string[]{};
    public String quryString{get;set;}
    public String QueryString {get;set;}
    public List<SelectOption> options{get;set;}
    public list<searchResultRow> searchResults {get;set;} 
    public Map<String,String> labelToAPIName = new Map <String, String>();      
    public String selectedObjAPIname {get;set;} 
    public String[] getSelectedObj() 
    {
        return selectedObj;
    }
    public void setSelectedObj(String[] selectedObj) 
    {
        this.selectedObj = selectedObj;
    }
    //Constructor
    public SearchItemController()
    {
       strSearchText ='Search...';              
       searchResults = new list<searchResultRow>();  
    } 
    public PageReference gotoHomePage()
    {
        PageReference page = new PageReference('https://ap1.salesforce.com/setup/forcecomHomepage.apexp?setupid=ForceCom&retURL=%2Fhome%2Fhome.jsp');
        page.setRedirect(true);
        return page;
    } 
    public List<SelectOption> getItems() 
    {                
        schemaObject= schema.getGlobalDescribe();    
        options = new List<SelectOption>();            
        for(Schema.SObjectType sObjType: schemaObject.values())
        {
            if(sObjType.getDescribe().isSearchable() && sObjType.getDescribe().isCreateable())
            { 
                Map<String,String> lstFieldName=new Map<String,String>();
                Map<String, Schema.SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();        
                for(Schema.SObjectField sfield : fieldMap.Values())
                {
                    schema.describefieldresult dfield = sfield.getDescribe();
                    lstFieldName.put(dfield.getName(),dfield.getName());
                }
                if(lstFieldName.containsKey('Name'))
                {                          
                     options.add(new SelectOption(sObjType.getDescribe().getLabel(),sObjType.getDescribe().getLabel()));
                     labelToAPIName.put(sObjType.getDescribe().getLabel(), sObjType.getDescribe().getName());
                }
             }
       }
          return options;          
    }      
    public list<list<sObject>> soslResults {
        get {                  
               string num='&%^$#@/-_';          
               if(strSearchText !='[0-9]'&& strSearchText.length()>1 && !strSearchText.contains(num) && (!selectedObj.isEmpty())) 
               {
                                                      
                    QueryString =  'FIND \''+strSearchText+'\' IN NAME FIELDS RETURNING ';                             
                    for(String sObj: selectedObj)
                     {
                         selectedObjAPIname = labelToAPIName.get(sObj);                                         
                         QueryString =  QueryString+selectedObjAPIname+'(Name),';                     
                     }           
                     integer len=QueryString.length() - 1;
                     quryString=QueryString.substring(0,len);
                     if((quryString.contains('*')) || (quryString.contains('?')) || (quryString.contains('"'))||(quryString.contains('((')) ||(quryString.contains('))')))
                     {                     
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Warning,'Your search term includes a search operator or wildcard: * (asterisk), ? (question mark), () (parentheses), or " " (quotation marks). Excluding these, your search term must have 2 or more characters.');
                         ApexPages.addMessage(myMsg);
                         soslResults = null;                                                                
                     } 
                     else{                    
                         soslResults = search.query(quryString);                                           
                     }                                   
                 }              
                 return soslResults;
            }              
        set;
       }        
      //Search Button Method                 
     public void searchResultsMethod(){        
         searchResults = new list<searchResultRow>();
         system.debug('debug1111----');                                                                                             
         if(soslResults!=null && strSearchText.length()>0){                 
            //Loop through the list of list of sObjects from our sosl query
            integer i = 0;
            for(list<sObject> objectList : soslResults){                    
                if(objectList.size()>0 ){
                    searchResults.add(new searchResultRow(objectList,selectedObj[i])); 
                }                                                         
                if(searchResults.size()<=0 && strSearchText !='Search...')
                {
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'No matches found');
                        ApexPages.addMessage(myMsg);
                } 
                i++;                                               
            } 
         } 
         soslResults=null;
        if(strSearchText =='Search...' ){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Please enter string');
            ApexPages.addMessage(myMsg);
        }              
        else if(strSearchText!=''&& selectedObj.isEmpty()){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please select object');
            ApexPages.addMessage(myMsg);
        }
        else if(strSearchText.length()<=1){    
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Your search term must have two or more characters');
             ApexPages.addMessage(myMsg);
        }                                                                                                                                             
     }
    //Wrapper Class              
    public class searchResultRow
    {
        public string sObjectTypeName {get;set;}
        public List<sObject> record {get;set;} 
        //Constructor       
        public searchResultRow(List<sObject> pObject,string objName) 
        {                       
            record = pObject;
            sObjectTypeName = objName;
        }
         
     }     
}