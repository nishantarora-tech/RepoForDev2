trigger shareObject on Auction__c (after insert,after update) {
    //List<Auction__Share> actnShrListObj = new List<Auction__Share>();
    //List<Auction__Share> actnShrListObj2 = new List<Auction__Share>();
    //List<Auction__Share> actnShrListObj3 = new List<Auction__Share>();
    Set<Id> usrIds = new Set<Id>();
    Set<Id> aucIds = new Set<Id>();
    //Profile pf = [select id from Profile where Name = 'Auction Bidders'];
    List<User> usrListObj = [Select name,IsActive,ProfileId from User where Profile.Name = 'Auction Bidders'];
    for(User usr : usrListObj){
        if(usr.isActive == True){
            usrIds.add(usr.id);
        }
    }           
    /*for(Auction__c auctn : Trigger.New){
       if(auctn.Status__c == 'Listed'){
           if(usrIds != Null){                                           
               for(ID usrId : usrIds){
                   Auction__Share actnShrObj = new Auction__Share(); 
                   actnShrObj.UserOrGroupId = usrId;
                   actnShrObj.ParentId = auctn.id;
                   actnShrObj.AccessLevel = 'Read';
                   //actnShrListObj.add(actnShrObj);
               }  
           }                                                       
       }else if(auctn.Status__c == 'Closed'){                      
             aucIds.add(auctn.id);                                      
       }
    }
    actnShrListObj2 = [select id from Auction__Share where UserOrGroupId in: usrIds and ParentId =: aucIds];
    for(Auction__Share auctionObj : actnShrListObj2){
        if(auctionObj.id != Null){
            actnShrListObj3.add(auctionObj);
        }
    }  
    if(actnShrListObj.size()>0){
        upsert actnShrListObj;
    }
    if(actnShrListObj3.size()>0){
        delete actnShrListObj3;
    }*/
}