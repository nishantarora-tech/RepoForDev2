public class ApexClassSearchController {
    public string searchApex{get;set;}
    public String selectedClassId{get;set;}
    public List<ApexClass> apexObjList{get;set;}
    public ApexClassSearchController (){
        apexObjList = new List<ApexClass>();
        searchApex = 'Search....';
    }
    public void search(){
        string strClass = '%' + searchApex + '%';
        apexObjList = [select id,name from ApexClass where Name LIKE :strClass  and NamespacePrefix = ''];
    }
    public PageReference redirectToApexClass(){
        PageReference pg = new PageReference('/'+selectedClassId);
        return pg;
    }
}