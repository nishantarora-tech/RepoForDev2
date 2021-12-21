public class StationAssignmentHandler {
	@future
    public static void stationAssignment(Set<id> assignStations){
        List<Station__c> stationList = [Select User__c from Station__c];
        List<Station__c> stationList2 = new List<Station__c>();
        Map<Id,Station__c> mapStation = new Map<Id,Station__c>();
        for(Station__c station : stationList){
            if(station.User__c != null){
                mapStation.put(station.User__c,station);
            }else{
                stationList2.add(station);
            }            
        }
        system.debug('mapStation----'+mapStation);
        List<Station__c> toBeUpdated = new List<Station__c>();
        Map<Id,User> usrMap = new Map<Id,User>([Select id,Assign_Station__c from User where id in: assignStations]); 
        system.debug('usrMap----'+usrMap);
        for(User usr : usrMap.values()){
            if(usr.Assign_Station__c == false){
                if(mapStation.size()>0){
                    mapStation.get(usr.Id).User__c = null;
                    toBeUpdated.add(mapStation.get(usr.Id));
                }
                
            }else{
                if(stationList2.size()>0){
                    stationList2[0].User__c = usr.Id;
                    toBeUpdated.add(stationList2[0]);
                }
            }
        }
        if(mapStation.size()>0 && toBeUpdated.size()>0){
            for(User usr : usrMap.values()){
            	if(usr.Assign_Station__c == true){
                	toBeUpdated[0].User__c = usr.Id;
                }
            }
        }
        system.debug('toBeUpdated----'+toBeUpdated);
        if(toBeUpdated.size()>0){
            try{
                update toBeUpdated;
            }catch(exception e){
                
            }
            
        }
    }
}