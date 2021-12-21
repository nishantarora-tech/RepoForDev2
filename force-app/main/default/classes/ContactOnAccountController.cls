public class ContactOnAccountController{
    public List<Contact> conList {get;set;}
    List<Account> accList {get;set;} 
    ContactWrapper wrpCon;
    public List<ContactWrapper> wrpConList {get;set;}   
    public contactOnAccountController(ApexPages.StandardController sc){        
        accList = new List<Account>();       
        wrpConList = new List<ContactWrapper>();
        conList = [SELECT AccountId,FirstName,LastName from Contact where FirstName != '' Limit 20];
        for(Contact c : conList){               
            wrpCon = new ContactWrapper(c);
            wrpConList.add(wrpCon);                          
        }                        
        for(ContactWrapper conWrp : wrpConList){
            if(conWrp.con.FirstName != Null && conWrp.con.AccountId == apexPages.CurrentPage().getParameters().get('Id')){
                conWrp.selected = True;
            }
        }
    }
    public pageReference addContact(){                
        Account acc = [Select id,(Select Id, FirstName,Name From Contacts where AccountID = : Apexpages.currentpage().getparameters().get('id')) from Account where Id =: Apexpages.currentpage().getparameters().get('id')];
        List<Contact> contactList = new List<Contact>();        
        List<Account_Share__c> accShareList = new List<Account_Share__c>();       
        for(ContactWrapper wrp : wrpConList){
            if(wrp.selected == True){             
                 wrp.con.AccountID = acc.Id;                                                                                                    
                 contactList.add(wrp.con);                                                                                                                                                                                                                                                                           
            }                                                                              
        }                      
        for(ContactWrapper conWrapper : wrpConList){
            if(conWrapper.selected == False && conWrapper.con.AccountId == acc.id){                                                                              
                conWrapper.con.AccountId = Null; 
                contactList.add(conWrapper.con);                          
            }
        }    
        if(contactList.size()>0){                           
               try{
                   update contactList;
               }catch(Exception e){}               
        }                 
        PageReference pg = new PageReference('/'+acc.id+'/e');
        pg.setRedirect(true);
        
        return pg;
    } 
    public pageReference Cancel(){
       Account accObj = [Select Name from Account where id = : ApexPages.CurrentPage().getParameters().get('id')];
       PageReference pgRef = new PageReference('/'+accObj.id);
       pgRef.setRedirect(true); 
       
       return pgRef;
    } 
    public class ContactWrapper{
        public Boolean selected{get;set;}
        public Contact con{get;set;}
        public ContactWrapper(Contact c){
            con = c;
            selected = false;
        }
    }   
    
    @InvocableMethod
    public static void hell()
    {
    }
}