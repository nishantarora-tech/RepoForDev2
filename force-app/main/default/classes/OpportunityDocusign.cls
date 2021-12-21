public class OpportunityDocusign{
    public PageReference insertDocusignData(Id oppId){
      Opportunity opp = [select id,name,closeDate from Opportunity where id =:oppId];
      Docusign__c docObj = new Docusign__c();
      docObj.name = opp.name;
      docObj.DocuSign__c = oppId;
      docObj.Close_Date__c = opp.closeDate;
      insert docObj;
      
      PageReference pg = new PageReference('apex/docusign_editenvelope?DSEID=a0H9000000IWRMtEAP&nw=0&rc=&SourceID=0069000000eeDkx');
      return pg;
 
    }
}