Public class listViewController{ 
 public List<Account> accList                 {get;set;}
 public List<String> strList                  {get;set;}
 public List<String> strToolsList             {get;set;}
 public List<String> strLinkList              {get;set;}
 //String[] SelectedValue= new String[]{}; 
 public string SelectedValue  {get;set;}
 public List<Account> accPicklistList {get;set;}
 public List<RecentlyViewed> rvList {get;set;}
 public string strViewed                      {get; set;} 
 public string strName                        {get;set;}
     
    public string getSelectedValue(){
            return SelectedValue;
    }
    public void setSelectedValue(string SelectedValue){
        this.SelectedValue= SelectedValue;
    }
    public listViewController(){     
     rvList = new List<RecentlyViewed>();
     acclist= [select name,phone from Account];              
     strList = new List<String>{'Active Accounts','Accounts with last activity > 30 days','Account Owners','Contact Role Report','Account History Report','Partner Accounts'};
     strLinkList = new List<String>{'Go to Reports »'};
     strToolsList = new List<String>{'Import My Accounts & Contacts','Import My Organization\'s Accounts & Contacts','Mass Delete Accounts','Transfer Accounts','Merge Accounts','Sales Methodologies'};                          
     if(SelectedValue=='Recently Viewed'){
         rvList=[SELECT Id, Name,Phone FROM RecentlyViewed WHERE Type ='Account' ORDER BY name DESC ];
       }
       accPicklistList=[SELECT Id, Name,Phone,LastViewedDate FROM Account WHERE LastViewedDate !=null ORDER BY name DESC]; 
       system.debug('rvList---'+rvList);
    }                
   /* public List<Account> picklistValue(String SelectedValue){
        List<Account> acc= new List<Account>();
        if(SelectedValue=='Recently Viewed'){
         List<RecentlyViewed> rv=[SELECT Id, Name,Phone FROM RecentlyViewed WHERE Type ='Account'ORDER BY name DESC ];
       } 
         return acc;     
    }  */                 
    public List<Account> picklistValues(){
      List<Account> accountList =[SELECT Name,Phone,LastViewedDate FROM account WHERE LastViewedDate !=null];
      return accountList;
    }     
    public PageReference accName(){        
        List<Account> accList = new List<Account>();
        accList=[SELECT id from Account where name=:strName];
        PageReference pgr= new PageReference ('/'+accList[0].id);
        pgr.setRedirect(true);
        return pgr;
    }
    public PageReference redirect(){
        PageReference pg = new PageReference('https://ap1.salesforce.com/001/e?retURL=%2F001%2Fo');
        pg.setRedirect(false);
        return pg;
    }
    /*public PageReference editLink(){
        PageReference pg1 = new PageReference('https://ap1.salesforce.com/ui/list/FilterEditPage?id=00B90000006bxz5&retURL=%2F001&cancelURL=%2F001%2Fo');
        pg1.setRedirect(false);
        return pg1;
    }
    public PageReference newViewLink(){
        PageReference pg2 = new PageReference('https://ap1.salesforce.com/ui/list/FilterEditPage?ftype=a&retURL=%2F001&cancelURL=%2F001%2Fo');
        pg2.setRedirect(false);
        return pg2;
    }*/
    public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('All Accounts','All Accounts'));
            options.add(new SelectOption('My Accounts','My Accounts'));
            options.add(new SelectOption('New Last Week','New Last Week'));
            options.add(new SelectOption('New This Week','New This Week'));
            return options;
        }
    public List<SelectOption> getPicklistValues() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Recently Created','Recently Created')); 
            options.add(new SelectOption('Recently Modified','Recently Modified'));            
            options.add(new SelectOption('Recently Viewed','Recently Viewed'));                           
            return options;
        }            
}