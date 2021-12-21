public class ContactPublisherOnCaseController {
    public Contact con{get;set;}
    public boolean hasError{get;set;}
    public Case objCase {get;set;}
    public String strButton {get;set;}
    public String strContact {get;set;}
    Contact contct = new Contact();
    public ContactPublisherOnCaseController(ApexPages.StandardController controller) {        
        if(ApexPages.CurrentPage().getParameters().get('Id') != null){
            objCase = new Case();
            //con = new Contact();
            objCase = [select contactId,AccountId from Case where Id=:ApexPages.CurrentPage().getParameters().get('Id')];
            /*if(objCase.contactId != null){
                con = [select firstName,LastName,Phone,Email,AccountId,MobilePhone from Contact where id=:objCase.contactId];
            } 
            if(con!=null){
                strButton = 'Update'; 
            }else{
                strButton = 'Save'; 
            }*/                                               
        }
    }
    public void contactInfo(){
        con = new Contact();
        if(objCase.contactId != null){                        
            Contact conObj = [Select id,firstName,LastName,AccountId,Email,Phone,MobilePhone from Contact where id=:objCase.contactId];
            system.debug('conObj-----'+conObj);
            con.id = conObj.id;
            con.firstName = conObj.firstName;
            objCase.AccountId = conObj.AccountId;
            con.LastName = conObj.LastName;
            con.Email = conObj.Email;
            con.phone = conObj.Phone;
            objCase.AccountId = con.accountId;
            contct = con;
            try{
                update objCase;
            }
            catch(exception e){                                                                
                Apexpages.addMessages(e);               
            }   
        }
        if(con.Id!=null){
            strButton = 'Update Contact'; 
        }else{
            strButton = 'Create New Contact'; 
        } 
        //return null;
    }
    public PageReference save(){             
        system.debug('contct---'+contct);
        system.debug('con---'+con);
        if(strButton == 'Update Contact'){            
            try{
                update con;            
                objCase.AccountId = con.accountId;
                //update objCase;
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Contact updated successfully'));
                return null;                
            }catch(exception e){                                                                
                Apexpages.addMessages(e);
                return null;
            }                                              
        }else if(strButton == 'Create New Contact'){
            try{            
                insert con;                
                objCase.ContactId = con.id;
                objCase.AccountId = con.accountId;                
                update objCase;
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'New contact created and updated on Case'));
                return null;
            }catch(exception e){
                Apexpages.addMessages(e);
                return null;
            }                        
        }   
        return null;             
    }
    public void newContact(){
       objCase.ContactId = null;
       objCase.AccountId = null;
       con = new Contact(); 
       strButton = 'Save';
    }
}