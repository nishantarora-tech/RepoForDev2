trigger EmailSending on Lead (before insert,before update) {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    Boolean sendMail = false;
    for(Lead myLead : Trigger.new){                
        if(myLead.Email != null && myLead.Rating == 'Warm'){
            if(Trigger.isInsert){
                sendMail = true;
            }else if (Trigger.oldMap.get(myLead.id).Rating != 'Warm'){
                sendMail = true;
            }            
        }   
        if(sendMail){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(myLead.Email);
            mail.setToAddresses(sendTo);
            mail.setReplyTo(UserInfo.getUserEmail());
            mail.setSenderDisplayName(UserInfo.getName());
            mail.setSubject('Email from Lead Trigger');
            String body = '';
            mail.setHtmlBody(body);
            mails.add(mail);   
        }
    }
    Messaging.sendEmail(mails);
}