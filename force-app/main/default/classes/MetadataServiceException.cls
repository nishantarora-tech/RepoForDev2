public class MetadataServiceException extends Exception { 
public static void handleSaveResults(MetadataService.SaveResult saveResult) {
    if(saveResult==null || saveResult.success)
        return;
    if(saveResult.errors!=null) {
        List<String> messages = new List<String>();
        messages.add(
            (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
            'occured processing component ' + saveResult.fullName + '.');
        for(MetadataService.Error error : saveResult.errors)
            messages.add(
                error.message + ' (' + error.statusCode + ').' +
                ( error.fields!=null && error.fields.size()>0 ?
                 ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
        if(messages.size()>0)
            throw new MetadataServiceException (String.join(messages, ' '));
    }
    if(!saveResult.success)
        throw new MetadataServiceException ('Request failed with no specified error.');
}

/**
 * Method cloneReport(String sFolderApiName, String sReportApiName, String tFolderApiName, String tReportApiName)
 * @param sFolderApiName: api name of the (source) folder of the report to clone
 * @param sReportApiName: api name of the (source) report to clone
 * @param tFolderApiName: api name of the (target) folder to create the cloned report in
 * @param tReportApiName: api name of the (target) cloned report 
 */
Public static void cloneReport(String sFolderApiName, String sReportApiName, String tFolderApiName, String tReportApiName) {
    MetadataService.MetadataPort service = new MetadataService.MetadataPort();
    service.SessionHeader = new MetadataService.SessionHeader_element();
    service.SessionHeader.sessionId = UserInfo.getSessionId();

    // Get the report to clone
    MetadataService.Report reportToClone = (MetadataService.Report) service.readMetadata('Report', new String[] { sFolderApiName+'/'+sReportApiName }).getRecords()[0];

    
    system.debug('reportToClone----'+reportToClone);
    // Instanciate a new one to attribute the same metadata from the report to clone
    MetadataService.Report apexReport = new MetadataService.Report();
    // Set the cloned report properties from parameters and the source report
    apexReport.name = reportToClone.name + ' Clone';
    apexReport.fullName = tFolderApiName + '/' + tReportApiName;
    apexReport.reportType = reportToClone.reportType;
    apexReport.description = reportToClone.description;
    apexReport.format = reportToClone.format;
    apexReport.filter = reportToClone.filter;
        apexReport.showDetails = reportToClone.showDetails;
        apexReport.sortColumn = reportToClone.sortColumn;
        apexReport.sortOrder = reportToClone.sortOrder;
        apexReport.groupingsAcross = reportToClone.groupingsAcross;
        apexReport.groupingsDown = reportToClone.groupingsDown;
        apexReport.chart = reportToClone.chart;
    apexReport.timeFrameFilter = reportToClone.timeFrameFilter;
    apexReport.columns = reportToClone.columns;

    // Create the report clone
    //List<MetadataService.SaveResult> results = service.createMetadata(new MetadataService.Metadata[] { apexReport });

    // Handle results
    //handleSaveResults(results[0]);
}
}