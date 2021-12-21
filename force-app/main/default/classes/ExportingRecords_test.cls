@isTest
public class ExportingRecords_test{
   @isTest public static void objectMethod(){
        ExportingRecords ExportingRecordsObj = new ExportingRecords();
        ExportingRecords.LeadInsertion LeadInsertionObj = new ExportingRecords.LeadInsertion();
        List<ExportingRecords.LeadInsertion> LeadInsertionObjList = new List<ExportingRecords.LeadInsertion>();
        LeadInsertionObj.firstname = 'Nishant';
        LeadInsertionObj.lastname = 'Arora';
        LeadInsertionObj.Company = 'Test';
        LeadInsertionObjList.add(LeadInsertionObj);
        ExportingRecords.importLead(LeadInsertionObjList);
        ExportingRecordsObj.exportAccountWSDL();
        ExportingRecordsObj.exportContactWSDL();
        ExportingRecordsObj.exportLeadWSDL();
        ExportingRecordsObj.exportOpportunityWSDL();
        ExportingRecordsObj.importWSDL();
        ExportingRecordsObj.loginWSDL();
        ExportingRecordsObj.accountExcel();
        ExportingRecordsObj.contactExcel();
        ExportingRecordsObj.leadExcel();
        ExportingRecordsObj.oppExcel();
        ExportingRecordsObj.partnerRecord();
        ExportingRecords.exportAccounts();
        ExportingRecords.exportContacts();
        ExportingRecords.exportLeads();
        ExportingRecords.exportOpportunity();
        ExportingRecords.Export('Account',60);
        ExportingRecords.Export('Contact',60);
        ExportingRecords.Export('Lead',60);
        ExportingRecords.Export('Opportunity',60);                              
    }
}