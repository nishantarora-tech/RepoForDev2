public with sharing class caseController {
    public list<case> caseList{get;set;}
    public caseController(ApexPages.StandardController controller) {
        caseList= new List<Case>();
        caseList=[select id,caseNumber,status,priority from case where caseNumber='00001030'];
    }

}