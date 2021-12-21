trigger StationAssignment on User (after update) {
    Set<id> assignStations = new Set<id>();
    for (Integer i=0;i<Trigger.new.size();i++) {
        if(Trigger.new[i].Assign_Station__c!=Trigger.old[i].Assign_Station__c){
            assignStations.add(Trigger.new[i].Id);
        }        
	}
    if(assignStations.size() > 0 ){
        StationAssignmentHandler.stationAssignment(assignStations);
    }    
}