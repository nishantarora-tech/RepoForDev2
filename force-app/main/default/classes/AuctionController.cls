public with sharing class AuctionController{        
    public Auction__c auctionObj {get;set;}           
    public string auctionTitle {get;set;}    
    public string tabName{get;set;}    
    public Attachment attachmentObj {get;set;}
    public Long totalAuctions {get;set;}
    public Integer totalClosedAuctions {get;set;}    
    public Integer hours {get;set;}
    public Integer minutes {get;set;}
    public Integer days {get;set;}
    public long seconds {get;set;}            
    public String photoURL {get;set;}
    public blob photo {get;set;}            
    public boolean flagBidder {get;set;}
    public boolean flagAdminPage {get;set;}
    public boolean flagSavePage {get;set;}
    public boolean flagEditPage {get;set;}
    public boolean flagImage {get;set;}
    public boolean flagEditButtonHide {get;set;}     
    public boolean flagException;  
    User loggedInUser;
    Profile pf;                                      
    // Constructor
    public AuctionController(ApexPages.StandardController sc){                         
        auctionObj = new Auction__c();                                         
        totalAuctions = 0;             
        totalClosedAuctions = 0;                                       
        List<Auction__c> auctionObjList = [select Title__c,Auction_Close_Time__c,Created_Date__c,Status__c from Auction__c];                    
        pf = [select id from profile where name=:'System Administrator' limit 1];        
        loggedInUser = [select name,ProfileId from User where Id =: UserInfo.getUserId()];
        if(loggedInUser.ProfileId == pf.id){
            flagAdminPage = true;            
        }else{
            flagBidder = true;            
        }                
        for(Auction__c aucObj : auctionObjList){
            if(aucObj.Status__c == 'Listed'){
                totalAuctions++;                                             
            }                                            
        }                 
        for(Auction__c aucObj : auctionObjList){            
            if(aucObj.Status__c == 'Listed' && aucObj.Created_Date__c.date()!= Null && aucObj.Auction_Close_Time__c.date() == aucObj.Created_Date__c.date()){
                totalClosedAuctions++;  
            }                                               
        }
    } 
    // Pagination with StandardSetController  
    public ApexPages.StandardSetController con {        
        get{
            if(con == null) {                
                con = new ApexPages.StandardSetController(database.getQueryLocator([Select auctionObj.Title__c,auctionObj.Status__c,auctionObj.Created_Date__c,auctionObj.Description__c,auctionObj.Auction_Close_Time__c FROM Auction__c auctionObj where auctionObj.status__c = 'Listed' OR (auctionObj.Status__c = 'Closed' and auctionObj.Auction_Close_Time__c > :Date.today().addDays(-7))]));
                // sets the number of records in each page set                                                               
                con.setPageSize(5);                  
            }                                    
            return con;
        }   
        set;     
    }      
    public List<Auction__c> getAuctionPagination() {        
        return (List<Auction__c>)con.getRecords();
    }
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get{                        
            return con.getHasNext();                       
        }
        set;
    }
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get{                           
            return con.getHasPrevious();                                            
        }
        set;
    }  
    public Integer PageSize{
        get{
            return con.getPageSize();
        }        
        set;
    } 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {        
            return con.getPageNumber();
        }
        set;
    }    
    // returns the first page of records
     public void first() {        
         con.first();        
     }
     // returns the last page of records
     public void last() {
         con.last();
     }
     // returns the previous page of records
     public void previous() {
         con.previous();
     }
     // returns the next page of records
     public void next() {
         con.next();
     } 
     public Integer ResultSize{
        get{           
            return con.getResultSize();
        }        
        set; 
    }         
    // Page Redirect to Auction Detail page of selected title
    public PageReference title(){
        Auction__c auc = [select id from Auction__c where Title__c = :auctionTitle LIMIT 1];        
        PageReference pgr= new PageReference ('/'+auc.id + '?' + 'retURL=/apex/AuctionHomePage?sfdc.tabName='+tabName);
        pgr.setRedirect(true);
        return pgr;        
    }
    // New Auction Button
    public void newAuction(){
        auctionObj = new Auction__c();        
        flagSavePage = True;
        flagAdminPage = false;                
    }
    // Cancel Button
    public void cancel(){
        flagSavePage = false;
        flagAdminPage = true;
    }
    // Save Button
    public void save(){                            
        try{            
            auctionObj.Created_Date__c = datetime.now();                     
            insert auctionObj; 
            flagException = false;
            auctionObj = [select Title__c,Auction_Close_Time__c,Status__c,Image__c,Description__c,File_Name__c from Auction__c where id = :auctionObj.id];                                                                                                          
        }                                             
        catch(DmlException e){
            ApexPages.addMessages(e);                                                
            flagException = true; 
            flagSavePage = true;                                                          
        }                                       
        Attachment attachmentObj = new Attachment();        
        attachmentObj.body = photo;        
        attachmentObj.name = 'image';       
        attachmentObj.parentid = auctionObj.id;        
        attachmentObj.ContentType = 'application/jpg';        
        try{
            if(attachmentObj.body != Null){
                insert attachmentObj;
             }             
        }
        catch(DMLException e){
            system.debug('AttachmentException'+e.getMessage());
        }       
        if(attachmentObj != Null){
            String attId = attachmentObj.Id; 
            if(attId != Null){       
                String attachmentId = attId.substring(0,15);
                auctionObj.Image__c = attachmentId;
            }  
            system.debug('Auction Image'+auctionObj.Image__c);             
            photoURL = '/servlet/servlet.FileDownload?file='+auctionObj.Image__c; 
        }                                                                                                                               
        if(attachmentObj.body != Null && flagException == false){
            try{
                update auctionObj;                 
            }catch(DmlException ex){                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getMessage()));
           }
        }else{
           photoURL = ''; 
        }                                                                            
        days = date.valueOf(system.now()).daysBetween(date.valueOf(auctionObj.Auction_Close_Time__c));      
        hours =  (system.now().hour() - (auctionObj.Auction_Close_Time__c).hour()) + (days*24);        
        minutes = system.now().minute() - (auctionObj.Auction_Close_Time__c).minute();           
        seconds = system.now().second()-(auctionObj.Auction_Close_Time__c).second();                   
        if(minutes < 0){
            hours = hours - 1;
            minutes = 60 + minutes;
        }       
       if(flagException == false){   
            flagSavePage = false;
            flagEditPage = true;                  
            flagBidder = false; 
            flagAdminPage = false;
        }           
        if(auctionObj.Status__c == 'Closed'){
            flagEditButtonHide = true;
        }                                    
    }
    // Add Picture
    public void addPicture() {                             
        Attachment attachmentObj1 = new Attachment();        
        attachmentObj1.body = photo;        
        attachmentObj1.name = 'testname';       
        attachmentObj1.parentid =[select id from Account where name = 'Acc1'].id;
        attachmentObj1.ContentType = 'application/jpg/png';        
        try{
            insert attachmentObj1;
        }
        catch(DMLException e){
            system.debug('Auction Exception'+e.getMessage());
        }        
        if(attachmentObj1 != Null){
            String attId1 = attachmentObj1.Id;
            String attachmentId1 = attId1.substring(0,15);                               
            photoURL = '/servlet/servlet.FileDownload?file='+attachmentId1;
        }
        flagImage = true;                      
      }
    // Edit Auction Button
    public PageReference editAuction(){
        PageReference editPage = new PageReference('/' +auctionObj.id+'/e'+ '?' + 'retURL=/apex/AuctionHomePage?sfdc.tabName='+tabName);
        return editPage;
    }
    // Sort Status column
    public void sortStatus(){                
        this.con = new ApexPages.StandardSetController(database.getQueryLocator([select auc.Title__c,auc.Auction_Close_Time__c,auc.Created_Date__c,auc.Status__c from Auction__c auc where auc.status__c = 'Listed' OR (auc.Status__c = 'Closed' and auc.Auction_Close_Time__c > :Date.today().addDays(-7)) order by auc.Status__c]));            
        con.setPageSize(5);
    } 
    // Sort Created Date column
    public void sortCreatedDate(){      
        if(loggedInUser.ProfileId == pf.id){
            this.con = new ApexPages.StandardSetController(database.getQueryLocator([select auc.Title__c,auc.Auction_Close_Time__c,auc.Created_Date__c,auc.Status__c from Auction__c auc where auc.status__c = 'Listed' OR (auc.Status__c = 'Closed' and auc.Auction_Close_Time__c > :Date.today().addDays(-7)) order by auc.Created_Date__c]));          
        }else{
           this.con = new ApexPages.StandardSetController(database.getQueryLocator([select auc.Title__c,auc.Auction_Close_Time__c,auc.Created_Date__c,auc.Status__c from Auction__c auc where auc.status__c = 'Listed' order by auc.Created_Date__c]));               
        }
        this.con.setPageSize(5);       
    }           
}