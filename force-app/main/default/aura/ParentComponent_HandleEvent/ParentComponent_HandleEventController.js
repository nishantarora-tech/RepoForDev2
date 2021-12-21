({
	handlerChildMessage : function(component, event, helper) {
        var message = event.getParam("message");            
        component.set("v.messageFromEvent",message);        
	},
    fireApplicationEvent : function(component, event, helper) {
        //debugger;
        var appEvent = $A.get("e.c:ApplicationEvent");        
        appEvent.setParams({
            "message": "Application Event"             
        });
        appEvent.fire();
    }
})