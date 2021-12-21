public class AccountandContactSearch{
    public string searchText {get;set;}
    public List<Account> accList {get;set;}
    public Account acc {get;set;}
    public boolean str {get;set;}    
    public void AccountandContactSearch(){
        str = false;
        accList = new List<Account>();
    }
    public void searchAcc(){
        accList = [Select name ,Phone,AnnualRevenue,(SELECT Name, Email FROM Contacts)  from Account where name =:searchText ];
        if(accList.size()>1){
            ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.Info, 'Your Search returned more than one Account');
            ApexPages.addMessage(apexMessage); 
        }
        if(accList.size() == 0){     
            ApexPages.Message apexMessage11 = new ApexPages.Message(ApexPages.Severity.Info, 'Your Search did not find any item');
            ApexPages.addMessage(apexMessage11);
            str = False;    
        }
        else{
            str = True;
        }
    }
}