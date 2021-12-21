trigger testTrigger  on Account (before update, after update, before insert, after insert) {
    if (Trigger.isBefore) {
        System.debug('********Trigger values***********');
        System.debug('***SFDC: before Trigger.old is: ' + Trigger.old);
        System.debug('***SFDC: before Trigger.oldMap is: ' + Trigger.oldMap);
        System.debug('***SFDC: before Trigger.new is: ' + Trigger.new);
    }
    
    if (Trigger.isAfter) {
        System.debug('********Trigger values***********');    
        System.debug('***SFDC: after Trigger.old is: ' + Trigger.old);
        System.debug('***SFDC: after Trigger.oldMap is: ' + Trigger.oldMap);
        System.debug('***SFDC: after Trigger.new is: ' + Trigger.new);
       
    }
}