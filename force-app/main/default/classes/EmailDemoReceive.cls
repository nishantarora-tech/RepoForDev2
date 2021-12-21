global class EmailDemoReceive implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.Inboundenvelope envelope) {
        Account account;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try {
            // Look for account whose name is the subject and create it if necessary
            if ([select count() from Account where Name = :email.subject] == 0) {
              account = new Account();
              account.Name = email.subject;
              insert account;
            }else {
                account = [select Id from Account where Name = :email.subject];
            }        
            // Convert cc'd addresses to contacts
            for (String address : email.ccAddresses) {
              Contact contact = new Contact();
              system.debug('email----'+address);
              Matcher matcher = Pattern.compile('<.+>').matcher(address);
              system.debug('matcher----'+matcher);
              // Parse addresses to names and emails
              if (matcher.find()) {
                String[] nameParts = address.split('[ ]*<.+>')[0].replace('"', '').split('[ ]+');
               
                contact.FirstName = nameParts.size() > 1 ? nameParts[0] : '';
                contact.LastName = nameParts.size() > 1 ? nameParts[nameParts.size()-1] : nameParts[0];
                contact.Email = matcher.group().replaceAll('[<>]', '');
              } else {
                contact.LastName = address;
                contact.Email = address;
              }     
              // Add if new
              if ([select count() from Contact where Email = :contact.Email] == 0) {
                contact.AccountId = account.Id;
                insert contact;
              }
            }
            // Save attachments, if any
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
              Attachment attachment = new Attachment();         
              attachment.Name = tAttachment.fileName;
              attachment.Body = Blob.valueOf(tAttachment.body);
              attachment.ParentId = account.Id;
              insert attachment;
            }
            for(Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
              Attachment attachment = new Attachment();         
              attachment.Name = bAttachment.fileName;
              attachment.Body = bAttachment.body;
              attachment.ParentId = account.Id;
              insert attachment;
            }
        }catch (Exception e) {
          result.success = false;
          result.message = 'Oops, I failed.';
          system.debug('Exception----'+e.getMessage());
        }
        return result;
    }
}