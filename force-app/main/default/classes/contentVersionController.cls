public class contentVersionController {
    public Contract cont{get;set;}
    public blob photo {get;set;}
    public String title {get;set;}
    public contentVersion contVer{get;set;}
    public string id;
    public contentVersionController(ApexPages.StandardController controller) {
        cont = new Contract();
        contVer = new contentVersion();
        title = '';
        id = Apexpages.currentpage().getParameters().get('id');
        if(Apexpages.currentpage().getParameters().get('id') != null)
            cont = [select id,ContractNumber,Total_Content_Version_on_Contract__c,ContractTerm from Contract where id =:Apexpages.currentpage().getParameters().get('id')];
    }      
    public PageReference save(){
        if(String.isBlank(title)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter title for content version'));
            return null;
        }
        else{
            contVer.Contract__c = cont.id;
            contVer.versionData = photo;
            contVer.title = title;
            insert contVer;
            PageReference pg = new PageReference('/'+cont.id);
            return pg;
        }
    }
    public PageReference cancel(){
        PageReference pg = new PageReference('/'+cont.id);
        return pg;
    }
}