/*
    Owner : Nishant Arora
    Company:Wipro Technologies
    Date:16/10/2014
*/
@isTest
public class PDMRTableControllerTest{        
    public static testMethod void PDMRTable(){               
        
        List<PDMR_Data__c> lstPDMRSprint= new List<PDMR_Data__c>();        
        
        //Custom Setting Object
        PDMR_Table_Details__c objCustomSetting= new PDMR_Table_Details__c();
            objCustomSetting.name='a';        
            objCustomSetting.PDMR_Field_API__c='Start_Date__c';        
            objCustomSetting.PDMR_Questions__c='Actual Start Date of the Scrum team activity for the Iteration';
            insert objCustomSetting;
            
        List<PDMR_Table_Details__c> lstPDMRQuestions= new List<PDMR_Table_Details__c>();
            lstPDMRQuestions.add(objCustomSetting);
                    
        PDMR_Table_Details__c objCustomSetting1= new PDMR_Table_Details__c();
            objCustomSetting1.name='e';  
            objCustomSetting1.PDMR_Field_API__c='Total_Engineering_Efforts__c';
            objCustomSetting1.PDMR_Questions__c='Total efforts of all Engineering activities in the Iteration.';
            insert objCustomSetting1;
        lstPDMRQuestions.add(objCustomSetting1);
                
        // PDMR Data Object        
        PDMR_Data__c objPDMR= new PDMR_Data__c();
            objPDMR.Vantiv_Teams__c='Cloud 9';
            objPDMR.Sprint__c='GT-2014-3-1';
            objPDMR.Start_Date__c=system.today();
            objPDMR.End_Date__c=system.today()+1;
          insert objPDMR ;
          lstPDMRSprint.add(objPDMR);          
          
         PDMR_Data__c objPDMR1= new PDMR_Data__c();
            objPDMR1.Vantiv_Teams__c='Code Express';
            objPDMR1.Sprint__c='GT-2014-3-1';
            objPDMR1.Vantiv_Teams__c='Code Express';
            objPDMR1.Start_Date__c=system.today();
            objPDMR1.End_Date__c=system.today()+1;           
          insert objPDMR1;
          lstPDMRSprint.add(objPDMR1);
          
          PDMR_Data__c objPDMR2= new PDMR_Data__c();
            objPDMR2.Vantiv_Teams__c='Giants';
            objPDMR2.Sprint__c='GT-2014-3-1';
            objPDMR2.Start_Date__c=system.today();
            objPDMR2.End_Date__c=system.today()+1;
          insert objPDMR2;
          lstPDMRSprint.add(objPDMR2);
          
          PDMR_Data__c objPDMR3= new PDMR_Data__c();
            objPDMR3.Vantiv_Teams__c='SFDC Enhancements';
            objPDMR3.Sprint__c='GT-2014-3-1';
            objPDMR3.Start_Date__c=system.today();
            objPDMR3.End_Date__c=system.today()+1;
          insert objPDMR3;
          lstPDMRSprint.add(objPDMR3);
          
          PDMR_Data__c objPDMR4= new PDMR_Data__c();
            objPDMR4.Vantiv_Teams__c='Team Phoenix';
            objPDMR4.Sprint__c='GT-2014-3-1';
            objPDMR4.Start_Date__c=system.today();
            objPDMR4.End_Date__c=system.today()+1;
          insert objPDMR4;
          lstPDMRSprint.add(objPDMR4);
            
            PDMR_Data__c objPDMR5= new PDMR_Data__c();
            objPDMR5.Vantiv_Teams__c='Titans';
            objPDMR5.Sprint__c='GT-2014-3-1';
            objPDMR5.Start_Date__c=system.today();
            objPDMR5.End_Date__c  = system.today()+1;
          insert objPDMR5;
          lstPDMRSprint.add(objPDMR5);                                                      
         
        ApexPages.CurrentPage().getParameters().put('sprint','GT-2014-3-1');
        // PDMRTableController Object
        PDMRTableController ObjPDMRTable=new PDMRTableController();
        // Calling methods of PDMRTableController 
        ObjPDMRTable.dateMethod('26','11','2013');                
        String encode=ObjPDMRTable.EncodeToUTF;       
        ObjPDMRTable.getPicklistValues();
        ObjPDMRTable.pageRedirect();
        //ObjPDMRTable.lstPDMRRecords.clear(); 
        ObjPDMRTable.lstPDMRRecords=ObjPDMRTable.pdmrRecords('');                                           
        ObjPDMRTable.displayPDMRRec();        
        //ObjPDMRTable.lstPDMRRecords=new List<PDMR_Data__c>();                       
        ObjPDMRTable.filterPDMRData(); 
        ObjPDMRTable.Download();                
                
        //Wrapper Class Object
        PDMRTableController.wrapperPDMR objWrapper= new  PDMRTableController.wrapperPDMR('','','','','','','','');                                            
     }
}