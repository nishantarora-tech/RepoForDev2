/* global class ID{  

 global class A{
 
     webservice ID id;
     webservice String status;
 }
        webservice static Map<ID,String> makeContact(A b){ 
        
            Map<Id> m= new Map<ID>();
                m.put(b.id);
            Map<String> m1= new Map<String>();
            m1.put(b.status);
                return m;
        }
} */

global class AccountPlan {
   
    webservice ID id;
     webservice String status;
      
    //Define an object in apex that is exposed in apex web service
     global class Plan {
        webservice String status;
        webservice ID id;
    }
   
     webservice static Plan createAccountPlan(Plan vPlan) {                  
        
        Map<ID,string> m= new Map<ID,string>();
        m.put(vplan.id,vplan.status);
          
         return vPlan;
    }
    
     }