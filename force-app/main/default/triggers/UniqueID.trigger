trigger UniqueID on Account (Before insert) {
integer i=math.round(math.random()*10);
for(Account a: Trigger.new)
{
    if(i==integer.valueof(a.Unique_ID__c))
    {
        a.Unique_ID__c=15;
    }
    else
         a.Unique_ID__c=i;
}
}