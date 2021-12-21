({
	saveAccount : function(component, event, helper) {
		var accountObj = component.get("v.accObj");
        if($A.util.isEmpty(accountObj.Name) || $A.util.isUndefined(accountObj.Name)){
            alert('Account Name is Required');
            return;
        }
        if($A.util.isEmpty(accountObj.AccountNumber) || $A.util.isUndefined(accountObj.AccountNumber)){
            alert('Account Number is Required');
            return;
        }
        var action = component.get("c.saveAccount");
        action.setParams({
            acc : accountObj
        });        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
            	var newAccount = {'sobjectType': 'Account',
                                    'Name': '',
                                    'AccountNumber': '',
                                    'AccountSource': ''                                   
                                   };
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Account has been inserted successfully."
                });
                toastEvent.fire();
                //resetting the Values in the form
                component.set("v.accObj",newAccount);
            }else if (state === "ERROR") {
                //Error message display logic.
                var errors = response.getError();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "ERROR!",
                    "message": errors[0].message
                });
                toastEvent.fire();
            }
        });
	}
})