public with sharing class RetryScheduler {

    public class RetryScheduler implements Schedulable {
    public void execute(SchedulableContext sc){
        Database.executeBatch(new RetryFailedAccountsBatch(), 200);
    }
}
}