public class CampaignMembers{
    public string searchText {get;set;}
    public string status {get;set;}
    public List<CampaignMember> CampaignList {get;set;}
    public List<CampaignWrapper> wrapprList{get;set;}
    public Account acc {get;set;}
    public boolean str {get;set;}    
    public void CampaignMembers(){
        str = false;
        CampaignList = new List<CampaignMember>();        
    }
    public void searchMembers(){
                
        String campaignName = ApexPages.currentpage().getParameters().get('userN');
        system.debug('campaignName----'+campaignName);
        status = 'sent';
        if(campaignName != ''){	
        	wrapprList = new List<CampaignWrapper>();        
	        CampaignList = [SELECT id,Contact.Name,Lead.Name,status FROM CampaignMember WHERE Campaign.Name= :campaignName];
	        for(CampaignMember obj : CampaignList){
	        	CampaignWrapper wrp = new CampaignWrapper();
		        wrp.ContactName = obj.Contact.Name;
		        wrp.campaignMemberId = obj.Id;
		        wrp.leadName = obj.Lead.Name;
		        wrp.status = obj.status;
		        wrapprList.add(wrp);
	        } 
	        system.debug('wrapprList----'+wrapprList);
        }
               
        /*if(CampaignList.size() == 0){     
            ApexPages.Message apexMessage11 = new ApexPages.Message(ApexPages.Severity.Info, 'Your Search did not find any item');
            ApexPages.addMessage(apexMessage11);
            str = False;    
        }
        else{
            str = True;
        }
        else{
	        Map<Id,string> memberIdMap = new Map<Id,String>();
	    	
	    	system.debug('wrapprList----'+wrapprList);
	    	for(CampaignWrapper wrpObj : wrapprList){
	    		if(wrpObj.Selected == true){
	    			memberIdMap.put(wrpObj.campaignMemberId,status);
	    		}else{
	    			ApexPages.Message apexMessageObj = new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one member');
	            	ApexPages.addMessage(apexMessageObj);
	    		}
	    	}
	    	system.debug('memberIdMap----'+memberIdMap);
	    	List<CampaignMember> memberLst = [select id,status from CampaignMember where id In:memberIdMap.keySet()];
	    	system.debug('memberLst----'+memberLst);
	    	List<CampaignMember> memberUpdateList = new List<CampaignMember>();
	    	for(CampaignMember objMember : memberLst){
	    		objMember.status = memberIdMap.get(objMember.id);
	    		memberUpdateList.add(objMember);
	    	}
	    	update memberUpdateList;
        }*/
    }
    public void updateStatus(){
    	Map<Id,string> memberIdMap = new Map<Id,String>();
    	String status = 'Sent';//ApexPages.currentpage().getParameters().get('status2');
    	system.debug('status----'+status);
    	for(CampaignWrapper wrpObj : wrapprList){
    		if(wrpObj.Selected == true){
    			memberIdMap.put(wrpObj.campaignMemberId,status);
    		}else{
    			ApexPages.Message apexMessageObj = new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one member');
            	ApexPages.addMessage(apexMessageObj);
    		}
    	}
    	List<CampaignMember> memberLst = [select id,status from CampaignMember where id In:memberIdMap.keySet()];
    	List<CampaignMember> memberUpdateList = new List<CampaignMember>();
    	for(CampaignMember objMember : memberLst){
    		objMember.status = memberIdMap.get(objMember.id);
    		memberUpdateList.add(objMember);
    	}
    	update memberUpdateList;
    }
    public class CampaignWrapper{
    	public Boolean selected{get;set;}
    	public Id campaignMemberId;
    	public String ContactName {get;set;}
    	public String leadName {get;set;}
    	public String status {get;set;}
    }
}