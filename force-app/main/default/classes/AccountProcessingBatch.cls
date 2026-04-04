public class AccountProcessingBatch implements Database.Batchable<sObject>, Database.Stateful {

    public Integer successCount = 0;
    public Integer failureCount = 0;
    public List<Id> failedIds = new List<Id>();

    // START
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Id, Name, Status__c 
            FROM Account 
            WHERE Status__c != 'Processed'
        ]);
    }

    // EXECUTE
    public void execute(Database.BatchableContext bc, List<Account> scope){

        for(Account acc : scope){
            acc.Status__c = 'Processed';
        }

        // Partial DML
        Database.SaveResult[] results = Database.update(scope, false);

        for(Integer i = 0; i < results.size(); i++){
            if(results[i].isSuccess()){
                successCount++;
            } else {
                failureCount++;
                failedIds.add(scope[i].Id);
            }
        }
    }

    // FINISH
    public void finish(Database.BatchableContext bc){

        System.debug('Success: ' + successCount);
        System.debug('Failures: ' + failureCount);

        // Store failed records for retry
        List<Retry_Record__c> retryList = new List<Retry_Record__c>();

        for(Id accId : failedIds){
            retryList.add(new Retry_Record__c(Account__c = accId));
        }

        if(!retryList.isEmpty()){
            insert retryList;
        }

        // Send email summary
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{'your@email.com'});
        mail.setSubject('Batch Processing Report');
        mail.setPlainTextBody(
            'Success: ' + successCount + 
            '\nFailures: ' + failureCount
        );

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
    }
}