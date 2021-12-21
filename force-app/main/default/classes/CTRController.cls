public class CTRController{
    public Case objCase{get;set;}
    public boolean hasError{get;set;}
    Public Id caseId;     
    public CTRController(){                
        caseId = ApexPages.currentPage().getParameters().get('id');
        objCase = [Select Id,Case_Category__c,Case_Type__c,Reason__c from Case where id =:caseId];
        System.debug('objCase----'+objCase);
    }
    public void Save(){                 
        if(!string.isEmpty(caseId)){                                     
            try{
                update objCase;
                hasError = false;
            }catch(exception e){
                ApexPages.addMessages(e);
                hasError = true;
            }                       
        }
    }
}