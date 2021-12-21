trigger emailToCase on Case (before insert) {
    case[] c = trigger.new; 
    String str;   
    String patternMatch;
    String partToBeMasked;     
    List<String> strNumberList = new List<String>();  
    /*if(c[0].Description != null){
        str = c[0].Description;
        Pattern p = Pattern.compile('(((\\d{4}-){3}\\d{4})|\\d{16})?');
        Matcher m = p.matcher( str );         
        while(m.find()){                      
            if(m.end() - m.start() == 19){
                patternMatch = str.substring(m.start(), m.end());                 
                partToBeMasked = patternMatch.substring(0, patternMatch.length()-5);                 
            }                             
        }                
    }*/
    Map<Id,String> caseMap = new Map<Id,String>();
    for(Case cObj : Trigger.new){
        if(cObj.Description != null){
            str = cObj.Description;
            Pattern p = Pattern.compile('(((\\d{4}-){3}\\d{4})|\\d{16})?');
            Matcher m = p.matcher( str );         
            while(m.find()){                      
                if(m.end() - m.start() == 19){
                    patternMatch = str.substring(m.start(), m.end());                 
                    partToBeMasked = patternMatch.substring(0, patternMatch.length()-5);    
                    caseMap.put(cObj.id,partToBeMasked);               
                }                                       
            }                
        }  
    }
    for(Case cs : Trigger.new){
        if(partToBeMasked !=null){
            cs.Description = cs.Description.replace(caseMap.get(cs.id),'xxxx-xxxx-xxxx');
        }
    }
}