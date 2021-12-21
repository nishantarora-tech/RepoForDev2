public class AccountContactInfoController
{
    public Contact con{get;set;}
    public Account Acc{get;set;}
    public List<Contact> lstContact{get;set;} 
    public Integer rowNum{get;set;}  
    public boolean flag1{get;set;}
    public boolean flag2{get;set;}
    public AccountContactInfoController(ApexPages.StandardController controller) 
    {    
        flag1=false;          
        rowNum=0;
        this.Acc=(Account)controller.getRecord();         
        lstContact= new List<contact>();
        con = new Contact();
    } 
    public void add()
    {
        flag1 = true;
    }
    public void addMore()
    {
        lstContact.add(con);
        con = new Contact();
        flag2=true;     
    }
    public void RemoveItems()
    {       
       rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('index'));
       lstContact.remove(rowNum);  
       rowNum--;
    }
    public PageReference save()
    {        
        insert Acc;                
        lstContact.add(con);        
        for(contact ct: lstContact)
        {
               ct.accountid=Acc.id;
        } 
        try{                          
            insert lstContact;
        }Catch(Exception e){
            system.debug('Contact Exception'+e.getMessage());
        }                
        PageReference pg= new PageReference('/'+Acc.id);
        pg.setRedirect(false);               
        return pg;
    } 
    public void clear()
    {
        acc = new Account();
    }   
    public void cancel()
    {
        flag1=false;       
    }     
}