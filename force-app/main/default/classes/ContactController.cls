public class ContactController {
    public List<Contact> lstContact{get;set;}
    public ContactController(ApexPages.StandardSetController controller) {
        if(ApexPages.currentpage().getParameters().get('id') !=null){
            lstContact = [select id,firstname,lastname from Contact where AccountId = :ApexPages.currentpage().getParameters().get('id')];
        }        
    }

}