({
	doInitHelper : function(component, event) {
        
		var action = component.get("c.getProductInfo");
        action.setParams({ "caseId" : component.get("v.recordId")});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                var recordlist=[];
                for(var i=0; i < records.length; i++){
                    recordlist.push(records[i]);
                    records[i].productName;
                    component.set('v.ProductName',records[i].productName);
                    component.set('v.Country',records[i].Country);
                    if(!records[i].isProductSelected){
                        component.set('v.isError', true);
                        var table = component.find("pricetable");
                        $A.util.removeClass(table, "slds-show"); 
						$A.util.addClass(table, "slds-hide");
                        break;
                    }
                        
                }
                component.set('v.productSummary',recordlist);
						                
            }
        });
        $A.enqueueAction(action);  
	}
})