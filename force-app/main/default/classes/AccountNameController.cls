public class AccountNameController{

    public AccountNameController() {}    

 public List<Account> accList{get;set;}
    public AccountNameController(ApexPages.StandardSetController controller) {
        accList = [Select name from Account];
    }
}