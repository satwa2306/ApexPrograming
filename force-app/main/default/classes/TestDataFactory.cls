/**
 * @description Centralized factory for creating test data with sensible defaults.
 *              All methods accept a doInsert flag for flexibility.
 *              Bulk methods create multiple records; single-record methods delegate to bulk.
 */
@isTest
public class TestDataFactory {

    // ─── Accounts ─────────────────────────────────────────────────────────

    /**
     * Creates a list of test Account records with various attributes for comprehensive testing.
     * @param count Number of accounts to create
     * @param doInsert Whether to insert the records into the database
     * @return List of Account records
     */
    public static List<Account> createAccounts(Integer count, Boolean doInsert) {
        List<Account> accounts = new List<Account>();
        List<String> industries = new List<String>{'Technology', 'Finance', 'Healthcare', 'Manufacturing', 'Retail'};
        List<String> ratings = new List<String>{'Hot', 'Warm', 'Cold'};
        List<String> types = new List<String>{'Customer', 'Prospect', 'Partner'};
        
        for (Integer i = 0; i < count; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                BillingCity = 'San Francisco',
                BillingState = 'CA',
                BillingCountry = 'USA',
                Industry = industries[Math.mod(i, industries.size())],
                Rating = ratings[Math.mod(i, ratings.size())],
                Type = types[Math.mod(i, types.size())],
                Phone = '415-555-' + String.valueOf(1000 + i).leftPad(4, '0'),
                Website = 'https://testaccount' + i + '.example.com',
                AnnualRevenue = 1000000 + (i * 100000),
                NumberOfEmployees = 100 + (i * 10)
            ));
        }
        if (doInsert) {
            insert accounts;
        }
        return accounts;
    }

    /**
     * Creates a single test Account record.
     * @param doInsert Whether to insert the record into the database
     * @return Account record
     */
    public static Account createAccount(Boolean doInsert) {
        return createAccounts(1, doInsert)[0];
    }

    /**
     * Creates an Account with specific field overrides.
     * @param fieldOverrides Map of field names to values
     * @param doInsert Whether to insert the record into the database
     * @return Account record
     */
    public static Account createAccount(Map<String, Object> fieldOverrides, Boolean doInsert) {
        Account acc = new Account(
            Name = 'Test Account',
            Industry = 'Technology',
            Rating = 'Hot',
            Type = 'Customer'
        );
        for (String fieldName : fieldOverrides.keySet()) {
            acc.put(fieldName, fieldOverrides.get(fieldName));
        }
        if (doInsert) {
            insert acc;
        }
        return acc;
    }

    // ─── Contacts ─────────────────────────────────────────────────────────

    /**
     * Creates Contact records associated with Accounts.
     * @param accounts List of parent Account records
     * @param countPerAccount Number of contacts to create per account
     * @param doInsert Whether to insert the records into the database
     * @return List of Contact records
     */
    public static List<Contact> createContacts(List<Account> accounts, Integer countPerAccount, Boolean doInsert) {
        List<Contact> contacts = new List<Contact>();
        Integer idx = 0;
        for (Account acc : accounts) {
            for (Integer i = 0; i < countPerAccount; i++) {
                contacts.add(new Contact(
                    FirstName = 'Test',
                    LastName = 'Contact ' + idx,
                    Email = 'test.contact' + idx + '@example.com',
                    AccountId = acc.Id
                ));
                idx++;
            }
        }
        if (doInsert) {
            insert contacts;
        }
        return contacts;
    }

    // ─── Users ────────────────────────────────────────────────────────────

    /**
     * Creates a test User with specified profile.
     * @param profileName Name of the profile to assign
     * @param doInsert Whether to insert the record into the database
     * @return User record
     */
    public static User createUser(String profileName, Boolean doInsert) {
        Profile p = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];
        String uniqueKey = String.valueOf(DateTime.now().getTime());

        User u = new User(
            FirstName = 'Test',
            LastName = 'User ' + uniqueKey,
            Email = 'testuser' + uniqueKey + '@example.com',
            Username = 'testuser' + uniqueKey + '@example.com.test',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id
        );
        if (doInsert) {
            insert u;
        }
        return u;
    }
}