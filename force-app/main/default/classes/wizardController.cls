public class wizardController {
    public Account acc {get;set;}
    public Contact con {get;set;}
    public Opportunity opp {get;set;}   
    public boolean page1{get;set;}
    public boolean page2{get;set;}
    public boolean page3{get;set;}
    public wizardController(){
        page1 = true;
        page2 = false;
        page3 = false;
        acc = new Account();
        opp = new Opportunity();
        con = new Contact();
    }   
    public Component.Apex.SectionHeader getHeaderWithSteps() {        
        Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
        if (page1) {
            sectionHeader.title = 'New Customer Opportunity';
            sectionHeader.subtitle = 'Step 1 of 3';            
            return sectionHeader;
        }else if(page2) {
            sectionHeader.title = 'New Customer Opportunity';
            sectionHeader.subtitle = 'Step 2 of 3';            
            return sectionHeader;
        }else{
            sectionHeader.title = 'New Customer Opportunity';
            sectionHeader.subtitle = 'Step 3 of 3';            
            return sectionHeader;
        }
    }
    public void Next(){        
        page1 = false;
        page3 = false;
        page2 = true;
    }
    public void Next2(){        
        page3 = true;
        page2 = false;        
        page1 = false;        
    }
    public void previous1(){
        page1 = true;
        page2 = false;
        page3 = false;
    }
    public void previous2(){
        page1 = false;
        page2 = true;
        page3 = false;
    }
    public PageReference cancel(){
        
        //page1 = true;
        //page2 = false;
        //page3 = false;
        PageReference pg = new PageReference('https://ap1.salesforce.com/setup/forcecomHomepage.apexp?setupid=ForceCom');
        acc = new Account(); 
        con = new Contact();   
        return pg;    
    }
    public PageReference save(){
        // Account insertion
        acc.Phone = con.Phone;
        insert acc;
        
        // Contact Insertion
        con.AccountId = acc.id;
        insert con;
        
        //Opportunity Insertion
        opp.AccountId = acc.id;
        insert opp;
        
        PageReference acctPage = new ApexPages.StandardController(acc).view();
        acctPage.setRedirect(true);
        return acctPage;        
        
    }

}