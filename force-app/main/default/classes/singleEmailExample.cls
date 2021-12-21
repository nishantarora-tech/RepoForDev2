public class singleEmailExample{
    public singleEmailExample(ApexPages.StandardController con){
        
    }
    public PageReference sendingEmail(){        
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        String[] sendingTo = new String[]{'nishant.arora@trantorinc.com'}; 
        semail.setToAddresses(sendingTo);                  
        
        semail.setSubject('Single Email message Example'); 
        semail.setPlainTextBody('Hello!!!!!!!!!!This is a test email to test single email message program'); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail}); 
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        return pg; 
    } 
}