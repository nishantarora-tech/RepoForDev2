public class ProductController
{
    public List<Product2> productResultsList   {get;set;}     
    public List<Document> docList              {get;set;} 
    public String strSearchText                {get;set;} 
    public String ProductImage                 {get;set;} 
    public String strProductImage              {get;set;}        
    public List<String> strDocIdsList          {get;set;}
    public ProductController()
    {
         productResultsList= new List<Product2>();  
         strDocIdsList =  new List<String>();                
          if(productResultsList!=null)
            productResultsList.clear();
            
         productResultsList=[select Name,Image__c,Product_Image__c from Product2];         
         docList=[select name from Document];                   
         for(Document doc:docList){
             strDocIdsList.add(doc.id);                          
         }                                                                                                                         
    }     
    public void Search(){   
          if(productResultsList!=null)
            productResultsList.clear();              
       if(strSearchText =='' ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Please enter string');
             ApexPages.addMessage(myMsg);
          }           
      else if(strSearchText.length()<=1){    
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Your search term must have two or more characters');
          ApexPages.addMessage(myMsg);
       }      
       else if(strSearchText.length()>1){            
           productResultsList=(List<Product2>)[FIND :strSearchText RETURNING Product2(Name,Product_Image__c)][0];
           //docList= (List<Document>)[FIND :strSearchText RETURNING Document(Name)][0];
               if(productResultsList.size()<=0){
                   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'No Matches Found');
                   ApexPages.addMessage(myMsg);                   
                }
                else{
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Found');
                    ApexPages.addMessage(myMsg);  
                }
         }                                  
    }          
}