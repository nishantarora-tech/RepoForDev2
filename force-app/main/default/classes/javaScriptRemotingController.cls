global class javaScriptRemotingController{
    public string objectName{get;set;}
    @RemoteAction
    global static List<PDMR_Data__c> getRecords(string objectName){
        List<PDMR_Data__c> pdmrObj = new List<PDMR_Data__c>();
        pdmrObj =[select id,name,Vantiv_Teams__c,Sprint__c from PDMR_Data__c where Vantiv_Teams__c =:objectName];
        return pdmrObj;
    }
}