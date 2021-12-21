public with sharing class shareButtonInAccountController{
    public List<User> usrList {get;set;}
    List<Account> accList {get;set;}
    UserWrapper wrpUsr;
    AccountShare accShare; 
    List<AccountShare> accShareList = new List<AccountShare>();
    List<AccountShare> accountShareList = new List<AccountShare>();
    public List<UserWrapper> wrpUsrList {get;set;}  
    public shareButtonInAccountController(ApexPages.StandardController sc){
        wrpUsrList = new List<UserWrapper>();
        accShare = new AccountShare();
        List<Profile> pfList = [Select id from Profile Where Name <> 'System Administrator'];
        usrList = [select Name from User where profileId In: pfList];
        for(User u : usrList ){               
            wrpUsr = new UserWrapper(u);
            wrpUsrList.add(wrpUsr);                          
        }  
       accountShareList = [Select AccountId,AccountAccessLevel,UserOrGroupId from AccountShare];
       System.debug('ShareList----'+accountShareList);
       for(AccountShare accountShare : accountShareList){
           if(accountShare.AccountAccessLevel == 'Edit' && accountShare.AccountId == apexpages.currentpage().getparameters().get('id')){
               wrpUsr.selected = True;                                             
           }
       }
    }
    public PageReference share(){        
        PageReference pg;   
        List<AccountShare> accShareList2 = new List<AccountShare>();               
        Account acc = [Select id from Account where id =: apexpages.currentpage().getparameters().get('id')];         
        for(UserWrapper wrp : wrpUsrList){
            if(wrp.selected == True){                                                                                           
                accShare.AccountId = acc.id;                    
                accShare.UserOrGroupId = wrp.usr.id;
                accShare.AccountAccessLevel = 'Edit'; 
                accShare.OpportunityAccessLevel = 'Edit';
                accShare.CaseAccessLevel = 'Edit';                                                                 
                accShareList.add(accShare);                                                                                                                                                                                                          
            }else{
                accShareList2 = [Select id from AccountShare where UserOrGroupId =: wrp.usr.id and AccountId =: acc.id];
            }
        } 
        if(accShareList.size() > 0){
              try{
                  insert accShareList; 
              }catch(Exception e){
                  
              }                                           
        }
        for(AccountShare acShr : accShareList2 ){
            if(acShr.id != Null)
                delete acShr;            
        }           
       // pg = new PageReference('/'+accShare.AccountId);
        //pg.setRedirect(false);                  
                                                               
       return pg;      
    }
    public PageReference cancel(){
       Account acc = [Select id from Account where id =: apexpages.currentpage().getparameters().get('id')];
       PageReference pg = new PageReference('/'+acc.id);
       pg.setRedirect(True);
       
       return pg;  
    }
    public class UserWrapper{
        public Boolean selected{get;set;}
        public User usr{get;set;}
        public userWrapper(User u){
            usr = u;            
            selected = false;
        }
    }   
}