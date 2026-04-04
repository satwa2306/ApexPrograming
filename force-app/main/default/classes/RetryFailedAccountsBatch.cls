public with sharing class RetryFailedAccountsBatch {
   
    public class RetryFailedAccountsBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Account__c FROM Retry_Record__c
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Retry_Record__c> scope){

        List<Account> accs = new List<Account>();

        for(Retry_Record__c rr : scope){
            accs.add(new Account(
                Id = rr.Account__c,
                Status__c = 'Processed'
            ));
        }

        update accs;

        // Clean retry records
        delete scope;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Retry completed');
    }
}
}