public class AccountDeletionController {
    public List<AccountWrapper> wrapperList{get;set;}
    public List<Account> accList; 
    public String accountId{get;set;}  
    List<Account> accountList = new List<Account>();
    public AccountDeletionController(){
        accList = [Select name from Account];
        AccountWrapper wrapperObj;    
        wrapperList = new List<AccountWrapper>();   
        for(Account accObj: accList){
            wrapperObj = new AccountWrapper(accObj);
            wrapperList.add(wrapperObj);
        }            
    }
    public void deleteAccount(){
        for(AccountWrapper wrp :wrapperList){
            if(wrp.selected == true){               
                accountList.add(wrp.acc); 
            }   
        }
        try{
            if(accountList.size()>0){
                delete accountList;
                //return null;                
            }                   
        }catch(Exception e){                       
            for(Account a:accountList){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));               
             }
        }
        //return null;
    }
    public class AccountWrapper{
        public Boolean selected{get;set;}
        public Account acc{get;set;}
        public AccountWrapper(Account a){
            acc = a;
            selected = false;
        }
    }
}