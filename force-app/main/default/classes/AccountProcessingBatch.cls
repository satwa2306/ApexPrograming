/**
 * Batch job that processes Account records with a non-processed status.
 *
 * Behavior:
 * - Queries Accounts where Status__c != 'Processed'.
 * - Attempts partial updates (allOrNone = false) to set Status__c to 'Processed'.
 * - Tracks successes and failures across batch chunks using Database.Stateful.
 * - Persists failed Account Ids into Retry_Record__c for later retry handling.
 * - Sends an email summary with total success/failure counts when the batch completes.
 */
public class AccountProcessingBatch implements Database.Batchable<sObject>, Database.Stateful {
  // Count of successfully updated Account records.
  public Integer successCount = 0;

  // Count of Account records that failed to update.
  public Integer failureCount = 0;

  // List of failed Account record Ids collected across execute invocations.
  public List<Id> failedIds = new List<Id>();

  /**
   * Selects Account records that still need processing.
   */
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [
        SELECT Id, Name, Status__c
        FROM Account
        WHERE Status__c != 'Processed'
      ]
    );
  }

  /**
   * Processes each batch scope by marking accounts as processed and performing
   * a partial update so valid records can succeed even if others fail.
   */
  public void execute(Database.BatchableContext bc, List<Account> scope) {
    for (Account acc : scope) {
      acc.Status__c = 'Processed';
    }

    // Use partial DML to allow independent success/failure handling per record.
    Database.SaveResult[] results = Database.update(scope, false);

    // Aggregate processing outcomes for final reporting.
    for (Integer i = 0; i < results.size(); i++) {
      if (results[i].isSuccess()) {
        successCount++;
      } else {
        failureCount++;
        failedIds.add(scope[i].Id);
      }
    }
  }

  /**
   * Finalizes the batch by logging summary metrics, persisting failed records
   * for retry, and sending an email report.
   */
  public void finish(Database.BatchableContext bc) {
    System.debug('Success: ' + successCount);
    System.debug('Failures: ' + failureCount);

    // Store failed records for retry.
    List<Retry_Record__c> retryList = new List<Retry_Record__c>();

    for (Id accId : failedIds) {
      retryList.add(new Retry_Record__c(Account__c = accId));
    }

    if (!retryList.isEmpty()) {
      insert retryList;
    }

    // Send email summary.
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(new List<String>{ 'your@email.com' });
    mail.setSubject('Batch Processing Report');
    mail.setPlainTextBody(
      'Success: ' + successCount + '\nFailures: ' + failureCount
    );

    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
  }
}
