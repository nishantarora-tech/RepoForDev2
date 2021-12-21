public class BankStatementController{
    
    public list<Bank_Statement__c> statementList{get;set;}
    public list<BankStatementWrapper> bankStatementWrapperList{get;set;}
    public Integer counter{get;set;}
    public Integer counter2{get;set;}
    
    public BankStatementController(){
           counter = 0;
           statementList = new list<Bank_Statement__c>(); 
           bankStatementWrapperList = new list<BankStatementWrapper>();
           statementList = [Select id,Deposits__c,Month__c from Bank_Statement__c where Account__c=:apexPages.currentPage().getParameters().get('id')];         
           for(Bank_Statement__c statementObj : statementList){
               BankStatementWrapper stmWrap = new BankStatementWrapper(statementObj); 
               counter++;
               stmWrap.counterWrap = counter;
               //stmWrap.bankObj = statementObj;
               bankStatementWrapperList.add(stmWrap);
           }
           for(Integer i=0;i<12-statementList.size();i++){
               BankStatementWrapper stmWrap = new BankStatementWrapper(new Bank_Statement__c()); 
               counter++;
               stmWrap.counterWrap = counter;
               bankStatementWrapperList.add(stmWrap);                
           }
       
    }        
    public PageReference saveOrUpdateRecord(){
        Integer param = Integer.valueOf(Apexpages.currentpage().getParameters().get('index'));
        system.debug('counter2----'+param);         
        list<Bank_Statement__c> updateStatementList;
        updateStatementList = new list<Bank_Statement__c>();
        list<Bank_Statement__c> updateStatementList2 = new list<Bank_Statement__c>();
        list<Bank_Statement__c> insertStatementList = new list<Bank_Statement__c>();
        system.debug('bankStatementWrapperList----'+bankStatementWrapperList);
         if(!bankStatementWrapperList.isEmpty()){
            for(BankStatementWrapper statementWrapper: bankStatementWrapperList){
                if(statementWrapper.counterWrap == param){ 
                    updateStatementList.add(statementWrapper.bankObj);
                }
            }
        }        
        system.debug('updateStatementList----'+updateStatementList);         
        for(Bank_Statement__c stmObj : updateStatementList){
            if(stmObj.id !=null){
                updateStatementList2.add(stmObj);
                
            }else{
                stmObj.Account__c= ApexPages.currentPage().getParameters().get('id');               
                insertStatementList.add(stmObj);
            }
        }
        if(!updateStatementList2.isEmpty()){
            update updateStatementList2;
            
        }
        if(!insertStatementList.isEmpty()){
            insert insertStatementList;
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Record has been successfully updated'));        
        system.debug('updateStatementList----'+updateStatementList); 
        return null;
    }
    
    public class BankStatementWrapper{
        public Bank_Statement__c bankObj{get;set;}
        public Integer counterWrap{get;set;}
        
        public BankStatementWrapper(Bank_Statement__c stm){
            this.bankObj = stm;  
             
        }
    }
    
}