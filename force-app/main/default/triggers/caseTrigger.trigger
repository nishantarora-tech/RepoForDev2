trigger caseTrigger on Case (before insert,before update) {
    List<Case_Skill__c> caseSkillList = Case_Skill__c.getAll().values();
    Map<String,String> caseMap = new Map<String,String>();
    List<String> lstreason;
    Map<String,List<String>> CRMap = new Map<String,List<String>>();
    BusinessHours bh =[select id from BusinessHours where name='Case Business Hours'];
    for(Case_Skill__c csObj :caseSkillList){
        caseMap.put(csObj.Case_Category__c+csObj.Case_Type__c+csObj.Reason__c,csObj.SLA_Days__c+','+csObj.Priority__c);
        if(CRMap.get(csObj.Case_Category__c+csObj.Case_Type__c)!=null){
            CRMap.get(csObj.Case_Category__c+csObj.Case_Type__c).add(csObj.Reason__c);
        }
        else{
            lstreason= new List<String>();
            lstreason.add(csObj.Reason__c);   
            CRMap.put(csObj.Case_Category__c+csObj.Case_Type__c, lstreason); 
        }
    }    
    for(Case cs: Trigger.New){
        if(caseMap.get(cs.Case_Category__c+cs.Case_Type__c+cs.Reason__c) != null){
            String[] CTRValues = caseMap.get(cs.Case_Category__c+cs.Case_Type__c+cs.Reason__c).split(',');           
            cs.Priority = CTRValues[1];
            cs.SLA_Days__c = decimal.valueOf(CTRValues[0]);
            if(!String.IsEmpty(CTRValues[0])){           
                cs.SLA_Date_Time__c = BusinessHours.add(bh.id, DateTime.now(), (integer.valueOf(CTRValues[0])*60)*60*10000L); 
                cs.SLA_Warning_D_T__c = BusinessHours.add(bh.id, Datetime.now(),((Integer.valueOf(CTRValues[0])*60)*60*10000L) -(60*60*4000L));          
                if (((cs.SLA_Date_Time__c.gettime() - System.now().gettime())/3600000)>3){
                    cs.SLA_Status__c='Within SLA';
                }
                else if((((cs.SLA_Date_Time__c.gettime() - System.now().gettime())/3600000)<=3) && (((cs.SLA_Date_Time__c.gettime() - System.now().gettime())/3600000)>0))
                {
                    cs.SLA_Status__c='Near SLA Exp';
                }
                else
                    cs.SLA_Status__c='Past SLA';
            }else{
                cs.SLA_Days__c=null;
                cs.SLA_Status__c='Not Applicable';
                cs.SLA_Date_Time__c=null;
            }
            }
            else if(cs.Case_Category__c != null && cs.Case_Type__c!= null && cs.Reason__c!= null){
                cs.addError('For the Category '+cs.Case_Category__c+' and type ' +cs.Case_Type__c+' the reason should be ' +CRMap.get(cs.Case_Category__c+cs.Case_Type__c));                       
            } 
            else{
                cs.Case_Category__c = 'New';
                cs.Case_Type__c = 'New';
                cs.Reason__c = '';
                cs.SLA_Status__c='Not Applicable';

            }
        
    }
}