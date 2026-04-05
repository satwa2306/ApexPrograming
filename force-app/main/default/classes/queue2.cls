public class queue2 implements queueable {

    
    @future
    public static void futuremethod()
    {
        system.debug('future method');
    }

    public static void Execute(queueablecontext sb){
        system.debug('queue 2');
        
       system.enqueuejob(new Queue1());
        
        futuremethod();
    }

   
}