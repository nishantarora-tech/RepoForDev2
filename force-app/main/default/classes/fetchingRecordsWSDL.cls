global class fetchingRecordsWSDL{    
    webService static fetchingRecordsWSDL.recordsResponse fetchingLastMonthRecords(String objectName){
        // Instance of wrapper class
        fetchingRecordsWSDL.recordsResponse responseObj = new fetchingRecordsWSDL.recordsResponse();
        // Last month
        Integer lastMonth = Date.today().addMonths(-1).month();
               
        if(objectName == 'Account' || objectName == 'Contact' || objectName == 'Opportunity' || objectName == 'Lead'){
            String queryStr = 'SELECT name FROM' + ' ' +objectName + ' ' + 'Where CALENDAR_MONTH(CreatedDate) = :lastMonth';   
            List<Sobject> sobjList = database.query(queryStr);
            if(sobjList != null){                
                responseObj.Status = 'Success'; 
                responseObj.Detail = 'Last Month Record of' + ' ' +objectName; 
                responseObj.objectRecord = sobjList;         
            } 
            else{
               responseObj.ErrorDetail = 'No Records found for' +objectName;
            }            
        }                    
        else{
           responseObj.Status = 'Failure'; 
           responseObj.ErrorDetail = 'Please Select the Appropriate Object.' +objectName + ' ' + 'is not an appropriate object for this request '; 
        }   
        return responseObj;                           
    }         
    global Class recordsResponse{
        webService String Status;
        webService String ErrorDetail;
        webService String Detail;
        webService List<sObject> objectRecord;
    }                 
}