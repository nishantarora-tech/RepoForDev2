public Class trackCaseOnAccountController{
    Id accId;
    Integer days;
    Integer hours;
    Integer minutes;
    List<Integer> dateList = new List<Integer>();
    public Map<String,List<Integer>> caseMap{get;set;}
    public trackCaseOnAccountController(ApexPages.StandardController con){
        accId = ApexPages.currentPage().getParameters().get('id');
        days = 0;
        hours = 0;
        minutes = 0;
        String Status = '';
        caseMap = new Map<String,List<Integer>>();  
        List<Case> caseList = [select id ,status,start_time__c,End_time__c from case where AccountId=:accId];
        
        for(Case cs:caseList){
            if(cs.End_Time__c != null && cs.Start_time__c!=null){
                days+= date.valueOf(cs.End_Time__c).daysBetween(date.valueOf(cs.Start_Time__c));      
                hours+=  cs.End_Time__c.hour() - (cs.Start_Time__c).hour() + (days*24);        
                minutes+= cs.End_Time__c.minute() - (cs.Start_Time__c).minute();
                Status = cs.status;
                dateList.add(days);
                dateList.add(hours);
                dateList.add(minutes);
                caseMap.put(Status,dateList);
            }
        }      
    }
}