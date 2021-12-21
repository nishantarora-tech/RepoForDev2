Public class ApprovalProcess{

    Public List<ProcessInstance> App{get;set;}
    public String strTargetId {get;set;}
    //Constructor
    public ApprovalProcess(ApexPages.StandardController controller) {
          App = GetAllApprovalData();
    }    
    public List<ProcessInstance> GetAllApprovalData(){
          return [SELECT Id,TargetObjectId,Status FROM ProcessInstance];
    }   
    public Id getWorkItemId(Id targetObjectId){
        Id retVal = null;
        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
                                                where p.ProcessInstance.TargetObjectId =: targetObjectId]){
            retVal = workItem.Id;
        }
        return retVal;
    }      
    Public void Approval(){        
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments('Approving request');
        req.setAction('Approve');
        req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        Id idTargetId = strTargetId;
        Id workItemId = getWorkItemId(idTargetId);
            if(workItemId == null){
              ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Not Approved');
              ApexPages.addMessage(myMsg);                    
              }
              else{
               req.setWorkitemId(workItemId);
                  // Submit the request for approval
                  Approval.ProcessResult result =  Approval.process(req); 
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Approved');
                  ApexPages.addMessage(myMsg);
             }
         App = GetAllApprovalData();
    }
}