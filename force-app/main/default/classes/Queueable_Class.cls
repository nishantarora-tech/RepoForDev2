public class Queueable_Class implements Queueable{
    public static void execute(QueueableContext context){
        Account acc = new Account(name = 'Test Acc');
        insert acc;
        
    }
    //Id apexJob = system.enqueueJob(new Queueable_Class());
}