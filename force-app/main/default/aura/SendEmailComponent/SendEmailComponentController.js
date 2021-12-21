({
	doInit : function(component, event, helper) {
		var action = component.get("c.sendingEmail");
		action.setParams({ leadId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {
			alert("From server: " + response.getReturnValue());

                // You would typically fire a event here to trigger 
                // client-side notification that the server-side 
                // action is complete
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                alert('Please enter email');
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	}
})