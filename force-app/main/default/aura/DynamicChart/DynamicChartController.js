({
    afterScriptsLoaded : function(component, event, helper) 
    {
        //var jsonData = component.get("v.data");
        //var dataObj = JSON.parse(jsonData);
        //console.log('jsonData===',jsonData);
       // console.log('dataObj===',dataObj);
        new Highcharts.Chart({
            chart: {
            renderTo: 'container',
            type: 'pie'
        },
        title: {
            text: '40/60'
        },            
        plotOptions: {
            pie: {
                shadow: false
            }
        },
        series: [{
            name: 'Browsers',
            data: [["Total Leads", 60], ["Converted", 40]],
            size: '100%',
            innerSize: '95%',
            showInLegend:false,
            dataLabels: {
                enabled: false               
            }
        }]
    });
    }
})