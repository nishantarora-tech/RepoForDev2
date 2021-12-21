({
	fireComponentEvent : function(component, event, helper) {
		var event1 = component.getEvent("messageEvent");
        event1.setParams({
            "message": "Component Event"
        });
        event1.fire();
	}
})