({
    doInit : function(component, event, helper) {
        var action = component.get("c.recentAccountList");       
        action.setCallback(this, function(data){
            component.set("v.accountList",data.getReturnValue());
        });       
        $A.enqueueAction(action);
    }
})