trigger studentFormCase on Case (before insert) {
    Set<String> studentRollNumber = new Set<String>();
    Map<String,Student__c> rollNumberToStudent = new Map<String,Student__c>();
    for(Case cs : Trigger.new){
        system.debug('cs---'+cs);
        if(cs.Subject.contains('Form related issue for Roll Number:')){
            String rollNumber = cs.Subject.substringAfter(':');
            studentRollNumber.add(rollNumber.trim());
        }
    }
    system.debug('studentRollNumber---'+studentRollNumber);
    if(!studentRollNumber.isEmpty()){
        List<Student__c> studentList = [Select id,Name from Student__c where Name In: studentRollNumber];
        for(Student__c obj : studentList ){
            rollNumberToStudent.put(obj.Name,obj);
        }
        system.debug('studentList---'+studentList);
        system.debug('rollNumberToStudent---'+rollNumberToStudent);
        for(Case cs : Trigger.new){
            if(cs.Subject.contains('Form related issue for Roll Number:')){
                if(rollNumberToStudent!=null && rollNumberToStudent.containsKey(cs.Subject.substringAfter(':'))){
                    cs.Student__c = rollNumberToStudent.get(cs.Subject.substringAfter(':')).Id;
                }
            }
        }
    }
}