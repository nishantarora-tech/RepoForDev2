Public with sharing Class PDMR_Controller{

   //Variables
    public PDMR_Data__c PDMR {get;set;}
    public String sprint,teams;
    public list<PDMR_Data__c> lstPDMR {get;set;}
    public list<PDMR_Data__c> strPDMRList{get;set;}
    
    //Constructor
      public PDMR_Controller(){
         PDMR =new PDMR_Data__c ();
         lstPDMR = new list<PDMR_Data__c>();
    }

    //Save method to save PDMR data for diffrent Teams
    public PageReference save(){
    Boolean isValid=true;
        if(PDMR.Sprint__c == null ){
                PDMR.Sprint__c.addError('Required field cannot be null');   
                isValid=false;  
            }
            if(PDMR.Start_Date__c ==null ){
                PDMR.Start_Date__c.addError('Required field cannot be null');
                isValid=false; 
            }
            if(PDMR.End_Date__c ==null ){
                PDMR.End_Date__c.addError('Required field cannot be null');
                isValid=false; 
            }
           if(PDMR.Start_Date__c >= PDMR.End_Date__c ){
              PDMR.Start_Date__c.addError('Start Date must be Less than End Date');
              isValid=false;  
            }
            if(PDMR.Vantiv_Teams__c == null ){
                 PDMR.Vantiv_Teams__c.addError('Required field cannot be null'); 
                 isValid=false; 
            }
           
      
     if(isValid==true){
           try{
           upsert PDMR;
           }
           Catch(Exception e){
           system.debug('Error Insert/update--'+e.getmessage());
           }
        PageReference pageRef=new PageReference('/apex/PDMRTable');
            pageRef.getParameters().put('sprint',PDMR.Sprint__c);
            pageRef.setredirect(false);
            return pageRef;
       }
      else{
       return null;
       } 
    }
 
 //Method to get the current sprint for View PDMR Table page
     public PageReference showPDMRPage(){
         PageReference pageRef = new PageReference('/apex/PDMRTable');
         pageRef.getParameters().put('sprint',PDMR.Sprint__c);
         pageRef.setredirect(false);
         return pageRef;
         
     }
     
    
    public void getPdmrDetails(){
         if(PDMR.Vantiv_Teams__c != null && PDMR.Sprint__c != null ){
             sprint = PDMR.Sprint__c;
             teams = PDMR.Vantiv_Teams__c; 
          try{
              PDMR = [Select Sprint__c ,Agility_Quotient__c,Builds_passed_in_Iteration__c,                                                                                                                                   
                                                Closed_Action_Items__c,
                                                Number_of_stories_Modified__c,
                                                Defects_Corrected_in_the_Iteration__c,
                                                Delivered_Completed_number_of_stories__c, 
                                                End_Date__c,
                                                LOC_Covered_through_Unit_Testing__c,
                                                No_of_User_stories_having_UTC_Traceabi__c,
                                                Number_of_stories_De_scoped_Customer_In__c,                                           
                                                Number_of_stories_added_after_start_of_I__c,
                                                Open_Defects_at_the_start_of_Iteration__c,
                                                Planned_number_of_stories_initially_pl__c,
                                                Planned_Story_Points_for_Sprint__c,
                                                Post_Release_Defects__c,
                                                Post_Sprint_Defects__c,
                                                Start_Date__c,
                                                Story_Points__c,
                                                Team_Capacity__c,
                                                Total_of_Action_Items__c,
                                                Total_of_builds_in_Iteration__c,
                                                Total_Actual_Effort__c,
                                                Total_Code_Size__c,
                                                Total_no_of_Test_Cases_Automated_UT_F__c,
                                                Total_Number_of_Test_Cases_UT_FT_ST_o__c,
                                                Total_number_of_user_stories_worked_in_S__c,
                                                Total_PM_Efforts__c,
                                                Total_Review_Efforts__c,Total_Testing_Efforts__c,Vantiv_Teams__c from PDMR_Data__c where Sprint__c =: sprint AND Vantiv_Teams__c =: teams];
            }
            Catch(QueryException e){
                PDMR = new PDMR_Data__c();
                PDMR.Sprint__c = sprint;
                PDMR.Vantiv_Teams__c = teams;
            }                                            
        }
    }
    
    public void cancel(){
     PDMR = new PDMR_Data__c();
    } 
}