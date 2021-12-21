trigger assetCreattion on OpportunityLineItem (after insert,before delete) {
    Set<ID> oppId = new Set<Id>();
    Set<String> assetNameSet = new Set<String>();
    Set<String> oliDelSet = new Set<String>();
    Set<String> oliNameSet = new Set<String>();           
    List<Asset> assetObjList = new List<Asset>();
    for(OpportunityLineItem oli :  trigger.isDelete ? Trigger.old : Trigger.new){        
        oppId.add(oli.OpportunityId); 
        oliDelSet.add(oli.ProductCode);                                                                 
    }    
    if(oppId != null){
        List<Opportunity> oppList = [select id,accountId from Opportunity where Id In :oppId and stageName = 'Closed Won'];       
        List<OpportunityLineItem> oliList = [select id,name,OpportunityId,ProductCode from OpportunityLineItem where OpportunityId In: oppId]; 
        List<Asset> assetLst = [select name from Asset where OpportunityAsset__c In :oppId];
        for(Asset assObj : assetLst){
           assetNameSet.add(assObj.name); 
        }        
        Map<Id,Id> accMap = new Map<Id,Id>(); 
        if(oppList.size()>0){
            for(OpportunityLineItem oli : oliList){
                oliNameSet.add(oli.ProductCode);
            }
            for(Opportunity oppObj : oppList){
                accMap.put(oppObj.id,oppObj.accountId);                
            }                                                   
            for(OpportunityLineItem oli : oliList){                
                if(!assetNameSet.contains(oli.ProductCode)){
                    Asset assetObj = new Asset();                
                    assetObj.name = oli.ProductCode;
                    assetObj.OpportunityAsset__c = oli.OpportunityId;
                    if(accMap.get(oli.OpportunityId) != null){                
                        assetObj.AccountId = accMap.get(oli.OpportunityId);
                        assetObjList.add(assetObj);
                    }
                }
            }           
            if(assetObjList.size()>0){
                insert assetObjList;
                List<Asset> assetList = [select id from Asset where OpportunityAsset__c In:oppId and name Not In :oliNameSet];
                if(assetList.size()>0){
                    delete assetList;
                } 
            }
        }
        if(Trigger.isDelete){
            List<Asset> assetList = [select id from Asset where OpportunityAsset__c In:oppId and name In :oliDelSet];            
            if(assetList.size()>0){
            delete assetList;
            update assetObjList;
            } 
        } 
    }  
}