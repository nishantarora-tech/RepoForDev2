public with sharing class PDMRTableController 
{
    //Variables
    public List<wrapperPDMR> wraprPDMRList                 {get;set;}
    public List<PDMR_Table_Details__c> lstPDMRQuestions    {get;set;}
    public List<PDMR_Data__c> lstPDMRSprint                {get;set;}
    public List<PDMR_Data__c> lstPDMRRecords               {get;set;}
    public List<PDMR_Data__c> lstPdmrData                  {get;set;}
    public String strSprint                                {get;set;}
    public List<SelectOption> options                      {get;set;}
    public wrapperPDMR wrpRecord                           {get;set;}
        
    //Constructor 
    public PDMRTableController() {       
        wraprPDMRList   = new List<wrapperPDMR>();
        lstPDMRRecords  = new List<PDMR_Data__c>();
        lstPdmrData     = new List<PDMR_Data__c>();
        options         = new List<SelectOption>(); 
        lstPDMRSprint   = new List<PDMR_Data__c>();          
        
        //Get Questions  from Custom setting                     
        lstPDMRQuestions = PDMR_Table_Details__c.getAll().values();
        lstPDMRQuestions.sort();                  
        strSprint=ApexPages.currentPage().getParameters().get('sprint'); 
        
        //Get All PDMR records 
        lstPDMRSprint = pdmrRecords(strSprint);         
        
        //Questions List
        for(PDMR_Table_Details__c pm : lstPDMRQuestions){ 
            String strCloud9='';
            String strCodeEx=''; 
            String strGiants='';
            String strEnhancements=''; 
            String strTitans='';
            String strTeamPhoenix='';   
            
            // PDMR Record         
            for(PDMR_Data__c objPDMR : lstPDMRSprint){   
                if(objPDMR.Vantiv_Teams__c =='Cloud 9'){                                          
                     if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c') {                                                                                                                     
                           strCloud9=dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                        }
                    else{
                           strCloud9  = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                        } 
                }
                else if(objPDMR.Vantiv_Teams__c =='Code Express' ){
                    if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c' ) { 
                             strCodeEx =dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                         }                        
                      else{
                            strCodeEx = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                       }                                                      
                } 
                else if(objPDMR.Vantiv_Teams__c =='Giants'){  
                    if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c' ) {
                         strGiants =dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                        }                        
                      else{
                            strGiants = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                       }                                                    
                }
                else if(objPDMR.Vantiv_Teams__c =='SFDC Enhancements'){   
                    if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c' ) {
                         strEnhancements =dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                        }
                    else{
                            strEnhancements = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                       }                                                      
                }
                else if(objPDMR.Vantiv_Teams__c =='Team Phoenix'){  
                    if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c' ) {
                         strTeamPhoenix =dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                       }                        
                      else{
                            strTeamPhoenix = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                       }                                                       
                }
                else  
                    if(pm.PDMR_Field_API__c == 'login_History__Start_Date__c' || pm.PDMR_Field_API__c == 'login_History__End_Date__c' ) { 
                        strTitans =dateMethod(String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).day()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).month()),String.valueof(Date.valueOf(objPDMR.get(pm.PDMR_Field_API__c)).year()));                                                       
                     }
                    else{
                            strTitans = string.valueOf(objPDMR.get(pm.PDMR_Field_API__c)); 
                     }                                    
              }    
            wraprPDMRList.add(new wrapperPDMR(pm.PDMR_Field_API__c,pm.PDMR_Questions__c,strCloud9,strCodeEx,strGiants,strEnhancements,strTeamPhoenix,strTitans));                                 
        } 
   }
   // Date 
   public String dateMethod(String Day,String Month,String Year){
       String strDay   = Day;
       String strMonth = Month;
       String strYear  =  Year;
       String DateOfSprint=Day+'/'+Month+'/'+Year;                                                                                                                                 
       return DateOfSprint;
   } 
   // Sprint Picklist Values 
   public List<SelectOption> getPicklistValues(){
        Schema.sObjectType objType = PDMR_Data__c.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe(); 
        Map<String, Schema.SObjectField> fieldMap = schema.getGlobalDescribe().get('login_History__PDMR_Data__c').getDescribe().fields.getMap();
        //objDescribe.fields.getMap(); 
        List<Schema.PicklistEntry> picklistValuesList = fieldMap.get('login_History__Sprint__c').getDescribe().getPickListValues();
        options.add(new selectOption('--None--','--None--'));
        for(Schema.PicklistEntry picklist : picklistValuesList){
               options.add(new SelectOption(picklist.getLabel(),picklist.getValue()));                   
        }
        return options; 
   }
   // Back Button 
   public PageReference pageRedirect(){
        PageReference pageRef= new PageReference('/apex/PDMR_Layout_Temp');
        pageRef.setredirect(false);
        return pageRef;
   }
   // PDMR Records According to selected Sprint from first page(PDMR)
   public List<PDMR_Data__c> pdmrRecords(String strSprintValue){                       
         lstPdmrData=[Select Start_Date__c,End_Date__c,Total_Actual_Effort__c,
                                            Total_Review_Efforts__c,
                                            Total_Testing_Efforts__c,
                                            Total_Engineering_Efforts__c,
                                            Planned_number_of_stories_initially_pl__c,
                                            Number_of_stories_added_after_start_of_I__c,
                                            Number_of_stories_De_scoped_Customer_In__c,
                                            Number_of_stories_Modified__c,
                                            Total_number_of_user_stories_worked_in_S__c,
                                            Number_of_stories_Accepted__c,
                                            No_of_User_stories_having_UTC_Traceabi__c,
                                            Post_Sprint_Defects__c,
                                            Post_Release_Defects__c,
                                            LOC_Covered_through_Unit_Testing__c,
                                            Total_Code_Size__c,
                                            Total_Number_of_Test_Cases_UT_FT_ST_o__c,
                                            Total_no_of_Test_Cases_Automated_UT_F__c,
                                            Planned_Story_Points_for_Sprint__c,
                                            Story_Points__c,
                                            Total_of_builds_in_Iteration__c,
                                            Builds_passed_in_Iteration__c,
                                            Team_Capacity__c,
                                            Defects_Corrected_in_the_Iteration__c,
                                            Total_defects__c,
                                            Agility_Quotient__c,
                                            Total_of_Action_Items__c,
                                            Closed_Action_Items__c,
                                            Sprint__c,
                                            Vantiv_Teams__c
                                            from PDMR_Data__c where Sprint__c=:strSprintValue];                                                      
              return lstPdmrData;
        }                 
        // PDMR Records according to selected Sprint from second page(PDMR Data Entry)   
        public List<PDMR_Data__c> displayPDMRRec(){                                      
                lstPDMRRecords = pdmrRecords(strSprint);                                   
                if(lstPDMRRecords.isEmpty()){
                    for(wrapperPDMR wrpPDMR: wraprPDMRList){     
                         wrpPDMR.strCloud9  = '';
                         wrpPDMR.strCodeExpress='';
                         wrpPDMR.strGiants='';
                         wrpPDMR.strEnhancements='';
                         wrpPDMR.strTeamPhoenix='';
                         wrpPDMR.strTitans='';                         
                    }
                 }                   
                return lstPDMRRecords;                     
        }
        // Display data accroding to changed sprint value
        public void filterPDMRData(){  
            for(wrapperPDMR wrpPDMR: wraprPDMRList){     
                         wrpPDMR.strCloud9  = '';
                         wrpPDMR.strCodeExpress='';
                         wrpPDMR.strGiants='';
                         wrpPDMR.strEnhancements='';
                         wrpPDMR.strTeamPhoenix='';
                         wrpPDMR.strTitans='';                         
            }                       
            for(wrapperPDMR wrpPDMR: wraprPDMRList){ 
                for(PDMR_Data__c objPDMR: displayPDMRRec()){                                                                                                                                                                                                         
                    if(objPDMR.Vantiv_Teams__c =='Cloud 9'){                                                             
                        if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c' ) { 
                            wrpPDMR.strCloud9=dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));                                                                                      
                           }
                        else{
                                 wrpPDMR.strCloud9  = string.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)); 
                            }
                      }                                                                                                                                                        
                    else if(objPDMR.Vantiv_Teams__c =='Code Express' ){                      
                        if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c' ) { 
                           wrpPDMR.strCodeExpress =dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));                                                                                      
                          }                            
                        else{
                             wrpPDMR.strCodeExpress = string.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)); 
                         }                                      
                    }                                                                                            
                    else if(objPDMR.Vantiv_Teams__c =='Giants' ){                                          
                        if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c' ) { 
                            wrpPDMR.strGiants =dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));                                                                                      
                        }
                        else{
                            wrpPDMR.strGiants = string.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)); 
                          }                                      
                    }                                                                                                                                                                                      
                    else if(objPDMR.Vantiv_Teams__c =='SFDC Enhancements'){                                                            
                        if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c' ) { 
                            wrpPDMR.strEnhancements =dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));
                        }
                        else{
                            wrpPDMR.strEnhancements = String.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)); 
                         }                                     
                     }                                       
                    else if(objPDMR.Vantiv_Teams__c =='Team Phoenix'){                                            
                        if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c' ) { 
                            wrpPDMR.strTeamPhoenix =dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));
                        }
                        else{
                            wrpPDMR.strTeamPhoenix = String.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)); 
                         }                                    
                     }                                        
                    else{                     
                       if(wrpPDMR.pdmr_Field_Api == 'login_History__Start_Date__c' || wrpPDMR.pdmr_Field_Api == 'login_History__End_Date__c') {
                          wrpPDMR.strTitans =dateMethod(String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).day()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).month()),String.valueof(Date.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api)).year()));
                        } 
                       else{
                            wrpPDMR.strTitans = String.valueOf(objPDMR.get(wrpPDMR.pdmr_Field_Api));
                        }                                               
                     }                                                                                                            
                }                                   
            }
        } 
        //Export to Excel 
       public pagereference Download(){
        PageReference exdownload = new PageReference('Apex/PDMRExportToExcel');       
        exdownload =  Page.PDMRExportToExcel;
        exdownload.setRedirect(false);         
        return exdownload ;       
       }       
       public string EncodeToUTF{
        get{
            return EncodingUtil.base64decode('77u/').tostring();
           }
        }
        // Wrapper Class       
      public Class wrapperPDMR{
        public String pdmr_Field_Api;
        public String DataPointName  {get;set;}
        public String strCloud9     {get;set;}
        public String strCodeExpress{get;set;}
        public String strGiants     {get;set;}
        public String strEnhancements{get;set;}
        public String strTitans {get;set;}
        public String strTeamPhoenix {get;set;}
        //Constructor of wrapperPDMR             
        public wrapperPDMR(String fieldApi,String DataPointName,String strCloud9,String strCodeExpress,String strGiants,String strEnhancements,String strTeamPhoenix,String strTitans){
            this.DataPointName = DataPointName;
            this.strCloud9= strCloud9;   
            this.strCodeExpress = strCodeExpress;
            this.strGiants = strGiants;
            this.strEnhancements=strEnhancements;
            this.strTeamPhoenix =strTeamPhoenix;
            this.strTitans =strTitans;   
            this.pdmr_Field_Api  =fieldApi;     
        }              
    }               
}