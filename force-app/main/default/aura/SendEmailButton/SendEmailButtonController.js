({
	callComp : function(component, event, helper) {
		var action = component.get("c.sendingEmail");
		action.setParams({ leadId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {			                
            }            
            else if (state === "ERROR") {
                var errors = response.getError();
                alert('Please enter email');                
            }
        });
        $A.enqueueAction(action);
	}
})