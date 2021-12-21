public class ComposeMailController {
    public String toAdd{get;set;}
    public String ccAdd{get;set;}
    public Boolean flag{get;set;}
    public String changeBodyStyle{get;set;}
    public List<Attachment> attachList {get;set;}
    public String Subject{get;set;}
    public String body{get;set;}
    public Attachment attachObj{get;set;}    
    public Boolean textAreaFlag{get;set;}     
    public OrgWideEmailAddress emailAddObj{get;set;}   
    String[] toAddresses = new String[]{};
    String[] ccAddresses = new String[]{};
    public ComposeMailController(){
        changeBodyStyle = 'Switch to Text-Only';
        attachList = new List<Attachment>();
        textAreaFlag = true;       
        attachObj = new Attachment();
        emailAddObj = [select id,Address,DisplayName from OrgWideEmailAddress  where DisplayName='Nishant Arora'];               
        flag = false;                              
    }    
    public void TextAreaChange(){
        /*if(textAreaFlag == false){
            changeBodyStyle == 'Switch to HTML-Only';
        } */  
        system.debug('style-----'); 
        if(changeBodyStyle == 'Switch to Text-Only'){            
            changeBodyStyle = 'Switch to HTML';           
        }else{            
            changeBodyStyle = 'Switch to Text-Only';
            
        }
    }
    public void sendEmail(){        
        if(toAdd.contains(',')){
            toAddresses =  toAdd.split(',');
            system.debug('toAddressesIn---'+toAddresses);
        }else{
            toAddresses.add(toAdd);
            system.debug('toAddresses---'+toAddresses);
        }
        if(ccAdd.contains(',')){
            ccAddresses =  ccAdd.split(',');
            system.debug('toAddressesIn---'+ccAddresses);
        }else{
            ccAddresses.add(ccAdd);
            system.debug('toAddresses---'+ccAddresses);
        }
        try{  
            Messaging.EmailFileAttachment emailAttachObj = new Messaging.EmailFileAttachment();            
            emailAttachObj.setFileName(attachObj.name);            
            emailAttachObj.setBody(attachObj.body);            
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            emailObj.setToAddresses(toAddresses);
            emailObj.setOrgWideEmailAddressId(emailAddObj.id);
            emailObj.setSubject(subject);
            emailObj.setHTMLBody(body);            
            emailObj.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachObj});                                    
            Messaging.SendEmailResult [] mails = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailObj});
            flag = true;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));
        }
        
    }
}