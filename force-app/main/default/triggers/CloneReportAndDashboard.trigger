trigger CloneReportAndDashboard on Account (after insert) {
    for(Account acc : trigger.new){
        AccessReportANDDashboardRESTAPI.getReportAndDashboard(acc.name);
    }
}