public class StudentRecordController {
    public Student__c studentObj{get;set;}
    public String selectedClass{get;set;}   
    public String officerName{get;set;}  
    public String officerId{get;set;} 
    public String officerEmail{get;set;}
    public Boolean flag {get;set;}
    public Boolean flag2 {get;set;}
    public Boolean block3 {get;set;}
    public Boolean flag3 {get;set;}
    public Boolean disableButton{get;set;}
    public Integer rollNumber{get;set;}
    
    public StudentRecordController(){
        studentObj = new Student__c();
        flag = true;
        flag2 = false; 
        block3 = false;
        disableButton = false;       
    }
    public List<SelectOption> getClasses(){
        List<SelectOption> options = new List<SelectOption>();
        List<Integer> numberLst = new List<Integer>();
        Map<Integer,Class__c> classToNumberMap = new Map<Integer,Class__c>();
        List<Class__c> clsList = [select Name from Class__c];                               
        for(Class__c cls: clsList){
            classToNumberMap.put(Integer.valueOf(cls.Name.substring(0, cls.Name.length() - 2)),cls);
            numberLst.add(Integer.valueOf(cls.Name.substring(0, cls.Name.length() - 2)));                                               
        }
        numberLst.sort();
        for(Integer classNumber : numberLst){
            options.add(new SelectOption(classToNumberMap.get(classNumber).Name,classToNumberMap.get(classNumber).Name)); 
        }                                     
        return options;        
    }
    public PageReference submitStudent(){                
        if((studentObj.City__c!=null && !studentObj.City__c.isAlpha()) || (studentObj.Country__c!=null && !studentObj.Country__c.isAlpha()) 
            || (studentObj.State__c!=null && !studentObj.State__c.isAlpha())){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter valid city,state and country'));
            return null;
        }
        if(studentObj.Street__c!=null && studentObj.Street__c.isAlpha()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter valid street number'));
            return null;
        }        
        else{
            flag2 = true;   
            flag = false;           
            return null;
        }
    }
    public PageReference submit(){        
        disableButton = true; 
        Class__c cls = [select id from Class__c where name=:selectedClass];
        studentObj.ClassName__c = cls.Id;        
        List<Student__c> studentList = [Select Roll_Number__c from Student__c order by CreatedDate Desc limit 1];
        if(studentList.size()>0 && studentList[0].Roll_Number__c!=null){
            rollNumber = Integer.valueOf(studentList[0].Roll_Number__c) + 1;
        }else if(studentList.size()==0){
            rollNumber = 1;
        }        
        try{
            studentObj.Roll_Number__c = rollNumber;            
            insert studentObj; 
            //flag = false;
            flag2 = false;
            block3 = true;             
            return null;
        }Catch(Exception e){            
            if(e.getMessage().contains('duplicate value found:')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Email is already registered with us. Please go back and add another email.'));
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));
            }
            return null;
        }        
    }
    public void cancel(){
        flag2 = false;
        flag= true;
        block3 = false;        
    }
}