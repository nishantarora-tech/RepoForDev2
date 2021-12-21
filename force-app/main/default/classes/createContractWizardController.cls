public class createContractWizardController {
    public contact con{get;set;}
    public Opportunity opp{get;set;}
    public Boolean flag{get;set;}
    public Boolean flag1{get;set;}
    public Id accId;
    public createContractWizardController(){
        accId = ApexPages.currentPage().getParameters().get('id');
        opp = new Opportunity();
        con = new Contact();
        flag = false;        
    }
    public void redirectToContactPage(){
     //PageReference pg = new PageReference('/apex/contactWizardOnAccount?id='+oppId );
     flag = false;
     //return pg;
    }
    public PageReference redirectToHomePage(){
     PageReference pg = new PageReference('/'+accId);     
     return pg;
    }
    public void redirectToAccountPage(){     
     flag = true;     
     //PageReference pg = new PageReference('/apex/AccountWizardOnOpportunity?id='+oppId );         
     //return pg;
    }
    public void oppSave(){        
        if(flag == false){
            opp.AccountId= accId;
            try{
            insert opp;
            }catch(exception e){
            }
            flag = true;
        }else{
            con.AccountId= accId;
            try{
                insert con;
            }catch(exception e){
            }
        }
    }
    public PageReference oppSaveAndReturn(){
        if(flag == false){
            opp.AccountId= accId;
            try{
            insert opp;
            }catch(exception e){
            }
            PageReference pg = new PageReference('/'+accId);
            return pg;
        }else{
            con.AccountId= accId;
            try{
            insert con;
            PageReference pg = new PageReference('/'+accId);
            return pg;
            }catch(exception e){
            return null;
            }
            
             
        }
    }
}