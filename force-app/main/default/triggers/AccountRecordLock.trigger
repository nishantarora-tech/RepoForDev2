trigger AccountRecordLock on Account (before update) {
    List<Approval.ProcessSubmitRequest> listPSR = new List<Approval.ProcessSubmitRequest>(); 
    Set<ID> setaccountids= new Set<ID>();  
    for(Account Acc:Trigger.new) { 
            Account OldAcc = Trigger.OldMap.get(acc.id);            
            Acc.Old_MID__c = OldAcc.MID__c;                
            if(Acc.Old_MID__c == Acc.MID__c ){ 
                // Create an approval request for the account
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Automatic submit.');
                req1.setObjectId(Acc.Id);                            
                // Submit the approval request for the account
                listPSR.add(req1) ; 
            
           }
          }
     List<Approval.ProcessResult> results = Approval.process(listPSR);        
    
}