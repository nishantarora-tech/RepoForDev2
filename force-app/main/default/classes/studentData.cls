global class studentData{
    webService static StudentRecord getStudentDetails(String rollNumber){
        StudentRecord studentObj = new StudentRecord();       
        List<Student__c> stuObj = [select Name__c,Father_s_Name__c,Mother_s_Name__c,Email__c,Country__c,ClassName__r.Name,State__c,City__c,Street__c from Student__c where Name like:rollNumber];
        System.debug('stuObj--'+stuObj);
        if(stuObj.size() == 1){
            studentObj.FatherName = stuObj[0].Father_s_Name__c;
            studentObj.MotherName = stuObj[0].Mother_s_Name__c;
            studentObj.StudentName = stuObj[0].Name__c;
            studentObj.State = stuObj[0].State__c;
            studentObj.Street = stuObj[0].Street__c;
            studentObj.City = stuObj[0].City__c;
            studentObj.Country = stuObj[0].Country__c;
            studentObj.className = stuObj[0].ClassName__r.Name;
            studentObj.Email = stuObj[0].Email__c;
            return studentObj;    
        }
        else{
            return null;   
        }
    }   
    global class StudentRecord{
        webService String FatherName;
        webService String MotherName;
        webService String StudentName;
        webService String State;
        webService String Street;
        webService String City;
        webService String Email;
        webService String Country;
        webservice String className;
    }   
}