trigger AuctionBiddersUsers on User (after insert,after update) {
    Set<Id> usrId = new Set<Id>();
    Profile pf = [select id from Profile where name = 'Auction Bidders'];
    for(User usr : Trigger.New){    
        if(usr.Profileid == pf.id){
            usrId.add(usr.id);
        }
    }    
    /*List<Auction__Share> auctionShrObjList = new List<Auction__Share>();
    List<Auction__c> auctionObjList = [select Status__c from Auction__c];
    for(Auction__c auctn : auctionObjList ){
        if(auctn.Status__c == 'Listed'){            
            Auction__Share actnShr = new Auction__Share();
            actnShr.ParentId = auctn.id;
            if(usrId.size()>0 && usrId != Null){
                actnShr.UserOrGroupId = [select id from User where id In :usrId].id;            
                actnShr.AccessLevel = 'Edit';          
                auctionShrObjList.add(actnShr);
            }
        }        
    }
    if(auctionShrObjList.size()>0 && auctionShrObjList != Null){
        //upsert auctionShrObjList;
    }*/
}