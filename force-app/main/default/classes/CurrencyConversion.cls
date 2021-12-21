global class CurrencyConversion{
    global class CurrencyResponse{                 
        webService String currencyName;
        webService String currencyCode;
        webService Decimal conversionRate;
        //webService List<sObject> conversionRateObj;                                                                          
    }
    webService static List<CurrencyConversion.CurrencyResponse> exportCurrencyRates(){
        
        List<CurrencyConversion.CurrencyResponse> responseObjList = new List<CurrencyConversion.CurrencyResponse>();
        
        String queryStr = 'Select name,Conversion_Rate__c,Currency_Code__c from Currency_Conversion_Rate__c';
        List<Currency_Conversion_Rate__c> sobjList = database.query(queryStr);
        //List<Sobject> sobjList = database.query(queryStr);
        for(Currency_Conversion_Rate__c obj : sobjList){
            CurrencyConversion.CurrencyResponse responseObj = new CurrencyConversion.CurrencyResponse();
            responseObj.currencyName = obj.Name;
            responseObj.currencyCode = obj.Currency_Code__c;
            responseObj.conversionRate = obj.Conversion_Rate__c;
            responseObjList.add(responseObj);
        }
         
        return responseObjList;              
    }
}