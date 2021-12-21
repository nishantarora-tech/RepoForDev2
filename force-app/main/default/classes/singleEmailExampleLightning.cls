public class singleEmailExampleLightning{
    @AuraEnabled
    public static void sendingEmail(Id leadId){        
        Lead ld = [Select id,Email from Lead where id=:leadId];
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        //String[] sendingTo = new String[]{'nishant.arora@trantorinc.com'}; 
        String[] sendingTo = new String[]{ld.email};
        semail.setToAddresses(sendingTo);                  
        
        semail.setSubject('Single Email message Example'); 
        semail.setPlainTextBody('Hello!!!!!!!!!!This is a test email to test single email message program'); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail}); 
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        //return pg; 
    } 
}