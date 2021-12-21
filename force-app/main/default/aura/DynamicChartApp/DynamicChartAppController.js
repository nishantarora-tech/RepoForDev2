({
    doInit : function(component, event, helper) 
    {
        var jsonData = '';
        var dataObj = [];
        dataObj[0] = {
            name: 'MTD 2016',
            data: [15,25,35]
        };
        dataObj[1] = {
            name: 'Prior Year',
            data: [10,35,45]
        };
        dataObj[2] = {
            name: 'Next Year',
            data: [15,20,32]
        };
        jsonData = JSON.stringify(dataObj);
        component.set("v.data",jsonData);
        console.log(dataObj, '======', jsonData);
        //component.find("compId").set("v.data", jsonData);
    }

})