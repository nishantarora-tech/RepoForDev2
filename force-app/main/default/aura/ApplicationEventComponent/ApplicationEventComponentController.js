({
	handleApplicationEvent : function(component, event, helper) {
		var message = event.getParam("message");
        console.log("message---"+message);
        component.set("v.messageFromEvent",message);
	}
})