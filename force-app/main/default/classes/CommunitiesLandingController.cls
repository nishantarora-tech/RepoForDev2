/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
public with sharing class CommunitiesLandingController {
    
    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {
        return Network.communitiesLanding();
    }
   /* public PageReference forwardToCustomAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return new PageReference(Site.getPathPrefix() + '/SiteLogin?startURL=' +
        EncodingUtil.urlEncode(startURL, 'UTF-8'));
    }*/
    public PageReference forwardToCustomAuthPage() {
        /*if(UserInfo.getUserType() == 'Guest'){
            return new PageReference('/partner');
        }
        else{
            return null;
        }*/
        return null;
    }
    public CommunitiesLandingController() {}
}