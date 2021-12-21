public class QuestionQuizController{
    public ApexPages.StandardSetController con{
    get{
        List<PDMR_Table_Details__c> lstQuestions = PDMR_Table_Details__c.getAll().values();
        lstQuestions.sort();
        con = new ApexPages.StandardSetController(lstQuestions);
        con.setPageSize(1);
        return con;
    }      
    set;  
    }
     public List<PDMR_Table_Details__c> getQuestionQuiz() {        
        return (List<PDMR_Table_Details__c>)con.getRecords();
    }
    public Boolean hasNext {
        get{                        
            return con.getHasNext();                       
        }
        set;
    }
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get{                           
            return con.getHasPrevious();                                            
        }
        set;
    }
    public Integer PageSize{
        get{
            return con.getPageSize();
        }        
        set;
    } 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {        
            return con.getPageNumber();
        }
        set;
    }    
    public void first() {        
     con.first();        
    }
     // returns the last page of records
    public void last() {
        con.last();
    }
    // returns the previous page of records
    public void previous() {
        con.previous();
    }
    // returns the next page of records
    public void next() {
        con.next();
    } 
    public Integer ResultSize{
        get{           
            return con.getResultSize();
        }        
        set; 
    }      
}