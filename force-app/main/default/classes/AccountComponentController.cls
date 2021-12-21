public class AccountComponentController {
	@AuraEnabled
    public static void saveAccount(Account acc){
        insert acc;
    }
}