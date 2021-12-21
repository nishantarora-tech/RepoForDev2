public class attachmentCustomRealatedList_Controller{
    public Attachment attachObj {get;set;}
    public Opportunity opp{get;set;}    
    public List<Attachment> attachList{get;set;}  
    public String Id;
    public String attachmentName{get;set;}
    public Boolean flagAttach{get;set;}
    public attachmentCustomRealatedList_Controller(ApexPages.StandardController con){                
        Id = ApexPages.CurrentPage().getParameters().get('Id');
        attachmentMethod();                
    }
    public void attachmentMethod(){
        attachList = new List<Attachment>();    
        attachList = [Select name,Body,ContentType,CreatedById from Attachment where ParentId = :Id];
        system.debug('attachList---'+attachList);                                      
        if(attachList.size()>0 ){
            flagAttach = true;    
        } 
    }    
    public PageReference attachFile(){                               
        PageReference pg = new PageReference('/p/attach/NoteAttach?pid='+Id +'&retURL=' +Id);                                        
        return pg;
    }
    public PageReference view(){
       Attachment attObj = [select id from Attachment where name = :attachmentName LIMIT 1];              
       PageReference pg = new PageReference('/servlet/servlet.FileDownload?file='+attObj.id);                                        
       return pg;        
    }        
    public void deleteAttachments(){        
       List<Attachment> attObjList = [select id from Attachment where Name=:attachmentName];
       delete attObjList;
       system.debug('attachList1---'+attachList);                                             
       attachmentMethod();       
    }
}