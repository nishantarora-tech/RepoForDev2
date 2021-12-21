/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CommunitiesLoginController {

    global CommunitiesLoginController () {}
    
    global PageReference forwardToAuthPage() {
      String startUrl = System.currentPageReference().getParameters().get('startURL');
      String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }
    // Code we will invoke on page load.
    global PageReference forwardToCustomAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        //return new PageReference(Site.getPathPrefix() + '/SiteLogin?startURL=' +
        //EncodingUtil.urlEncode(startURL, 'UTF-8'));
        return new PageReference(Site.getPathPrefix() + '/login');
        
    }
}