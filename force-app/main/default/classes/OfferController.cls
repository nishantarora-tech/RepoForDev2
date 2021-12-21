public class OfferController{
    public List<login_History__Offer__c> offList{get;set;}
    public String offerId{get;set;}
    public boolean disabl {get;set;}
    public OfferController(){
        /*String appId = ApexPages.CurrentPage().getParameters().get('applicationId');
        system.debug('appId---'+appId);
        Id applicationId = [Select id from Application__c where name=:appid limit 1].id;
        offList = [Select id,login_History__of_Days__c,login_History__Advance_Amount__c,login_History__Commission2__c,login_History__Commission__c,login_History__Daily_Payment__c,login_History__Payback_Amount__c,login_History__Selected_Offer__c from login_History__Offer__c where login_History__Application__c=:applicationId];
        system.debug('offlIst---'+offList);*/
    }
    public void getOfferDetail(){
        String appId = ApexPages.CurrentPage().getParameters().get('applicationId');
        system.debug('appId---'+appId);
        if(!string.isBlank(appId)){
            Id applicationId = [Select id from Application__c where name=:appid limit 1].id;
            offList = [Select id,login_History__of_Days__c,login_History__Advance_Amount__c,login_History__Commission2__c,login_History__Commission__c,login_History__Daily_Payment__c,login_History__Payback_Amount__c,login_History__Selected_Offer__c from login_History__Offer__c where login_History__Application__c=:applicationId];
            system.debug('offlIst---'+offList);
        }     
    }
    public void acceptOffer(){
        system.debug('offerId---'+offerId);
        if(!string.isBlank(offerId)){
            List<Offer__c> ofr = [Select id,Selected_Offer__c from Offer__c where id=:offerId];
            if(ofr.size()>0){
                ofr[0].Selected_Offer__c = true;
                disabl=true;
                update ofr;
            }
            getOfferDetail();
        }
    }
}