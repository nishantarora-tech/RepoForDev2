/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public class CommunitiesSelfRegController {

    public String firstName {get; set;}
    public String lastName {get; set;}
    public String selectedAccount{get;set;}    
    public String email {get; set;}
    List<Account> accList = new List<Account>();
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController() {
        accList = [select id,name from Account where isPartner=true];   
    }
    public List<SelectOption> getAccounts() {        
        List<SelectOption> accOptions = new List<SelectOption>();
         for(Account acc:accList){
             accOptions.add(new SelectOption(acc.name,acc.name));
         }
         return accOptions;
    }
    /*public List<SelectOption> getProfiles() {        
        List<SelectOption> profileOptions = new List<SelectOption>();
         for(Profile p:accList){
             profileOptions.add(new SelectOption(acc.name,acc.name));
         }
         return accOptions;
    }*/
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
    public PageReference passwordReset(){                       
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }else{ 
            PageReference page = System.Page.CommunitiesSelfRegConfirm;
            page.setRedirect(true);
            return page;   
        }     
    }
    public PageReference registerUser() {              
        String profileId = '00e90000000gYoQ'; 
        String roleEnum = null; 
        List<Account> accId = [select id from Account where name=:selectedAccount];
        String accountId =accId[0].id;      
        String userName = email;
        User u = new User();
        u.Username = userName;
        u.Email = email;
        u.FirstName = firstName;
        u.LastName = lastName;
        u.CommunityNickname = communityNickname;
        u.ProfileId = profileId;  
              
        String userId = Site.createPortalUser(u, accountId,password);                       
        if (userId != null) {                                                
            if (password != null && password.length() > 1) {
                return Site.login(userName, password, ApexPages.currentPage().getParameters().get('startURL'));
            }
            else{
                PageReference page = System.Page.submitPageCommunity;
                page.setRedirect(false);
                return page;
            }
        }
        return null;
    }
}