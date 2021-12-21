public class ProductManagementController{
    public Product2 Prod    {get;set;}
    public ProductManagementController(ApexPages.StandardController controller){
        prod= new Product2();        
        this.Prod=(Product2)controller.getRecord();
    }
    public void clear(){
        Prod = new Product2();
        
    } 
    public PageReference save(){
        insert Prod;
        PageReference pg= new PageReference('/'+Prod.id);
        pg.setRedirect(true);               
        return pg;
    }
      
}