({
	navigateToComponent : function(component, event, helper) {
		var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:CustomLookup",
            componentAttributes: {
                oppId : component.get("v.recordId")
            }
        });
        evt.fire();
	}
})