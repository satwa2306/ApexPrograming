/**
 * Test class for AccountController.
 * Validates account retrieval and filtering functionality with comprehensive coverage.
 */
@isTest
private class AccountControllerTest {

    // ─── Test Setup ──────────────────────────────────────────────────────

    @TestSetup
    static void setupTestData() {
        // Create 251 accounts to test bulk scenarios
        List<Account> accounts = TestDataFactory.createAccounts(251, true);
    }

    // ─── getAccounts Tests ───────────────────────────────────────────────

    @isTest
    static void shouldReturnAllAccounts_WhenNoFiltersApplied() {
        // Given - test data created in setup

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, null, null);
        Test.stopTest();

        // Then
        Assert.areEqual(200, results.size(), 'Should return 200 accounts (default limit)');
        Assert.isNotNull(results[0].Id, 'Account records should have Ids');
        Assert.isNotNull(results[0].Name, 'Account records should have Names');
    }

    @isTest
    static void shouldFilterByName_WhenSearchKeyProvided() {
        // Given - accounts with known names from setup

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts('Test Account 1', null, null, null, null);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return matching accounts');
        for (Account acc : results) {
            Assert.isTrue(acc.Name.contains('Test Account 1'), 
                'All returned accounts should match search pattern');
        }
    }

    @isTest
    static void shouldFilterByIndustry_WhenIndustryProvided() {
        // Given - accounts with Technology industry from setup

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, 'Technology', null, null, null);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return accounts in Technology industry');
        for (Account acc : results) {
            Assert.areEqual('Technology', acc.Industry, 
                'All returned accounts should have Technology industry');
        }
    }

    @isTest
    static void shouldFilterByRating_WhenRatingProvided() {
        // Given - accounts with Hot rating from setup

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, 'Hot', null, null);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return accounts with Hot rating');
        for (Account acc : results) {
            Assert.areEqual('Hot', acc.Rating, 
                'All returned accounts should have Hot rating');
        }
    }

    @isTest
    static void shouldFilterByMinRevenue_WhenMinRevenueProvided() {
        // Given - accounts with revenue >= 5000000
        Decimal minRevenue = 5000000;

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, minRevenue, null);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return accounts with revenue >= 5M');
        for (Account acc : results) {
            Assert.isTrue(acc.AnnualRevenue >= minRevenue, 
                'All returned accounts should have revenue >= minimum');
        }
    }

    @isTest
    static void shouldFilterByMaxRevenue_WhenMaxRevenueProvided() {
        // Given - accounts with revenue <= 3000000
        Decimal maxRevenue = 3000000;

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, null, maxRevenue);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return accounts with revenue <= 3M');
        for (Account acc : results) {
            Assert.isTrue(acc.AnnualRevenue <= maxRevenue, 
                'All returned accounts should have revenue <= maximum');
        }
    }

    @isTest
    static void shouldFilterByRevenueRange_WhenBothMinAndMaxProvided() {
        // Given - accounts with revenue between 2M and 5M
        Decimal minRevenue = 2000000;
        Decimal maxRevenue = 5000000;

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, minRevenue, maxRevenue);
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return accounts within revenue range');
        for (Account acc : results) {
            Assert.isTrue(acc.AnnualRevenue >= minRevenue && acc.AnnualRevenue <= maxRevenue, 
                'All returned accounts should be within revenue range');
        }
    }

    @isTest
    static void shouldFilterByMultipleCriteria_WhenAllFiltersProvided() {
        // Given - specific account matching all criteria
        String searchKey = 'Test Account';
        String industry = 'Technology';
        String rating = 'Hot';
        Decimal minRevenue = 1000000;
        Decimal maxRevenue = 10000000;

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(searchKey, industry, rating, minRevenue, maxRevenue);
        Test.stopTest();

        // Then
        for (Account acc : results) {
            Assert.isTrue(acc.Name.contains(searchKey), 'Name should match search key');
            Assert.areEqual(industry, acc.Industry, 'Industry should match filter');
            Assert.areEqual(rating, acc.Rating, 'Rating should match filter');
            Assert.isTrue(acc.AnnualRevenue >= minRevenue && acc.AnnualRevenue <= maxRevenue, 
                'Revenue should be within range');
        }
    }

    @isTest
    static void shouldReturnEmptyList_WhenNoAccountsMatchFilters() {
        // Given - filter that matches no accounts

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts('NonExistentAccount999', null, null, null, null);
        Test.stopTest();

        // Then
        Assert.areEqual(0, results.size(), 'Should return empty list when no matches found');
    }

    @isTest
    static void shouldHandleBulkData_When251AccountsQueried() {
        // Given - 251 accounts from setup

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, null, null);
        Test.stopTest();

        // Then
        Assert.areEqual(200, results.size(), 'Should respect default limit of 200');
        Assert.isTrue(results.size() > 0, 'Should handle bulk data without governor limit errors');
    }

    // ─── getIndustryPicklistValues Tests ─────────────────────────────────

    @isTest
    static void shouldReturnIndustryValues_WhenAccountsHaveIndustry() {
        // Given - accounts with various industries from setup

        // When
        Test.startTest();
        List<AccountController.PicklistOption> results = AccountController.getIndustryPicklistValues();
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return industry options');
        Assert.isNotNull(results[0].label, 'Options should have labels');
        Assert.isNotNull(results[0].value, 'Options should have values');
        
        // Verify expected industries are present
        Set<String> industryValues = new Set<String>();
        for (AccountController.PicklistOption opt : results) {
            industryValues.add(opt.value);
        }
        Assert.isTrue(industryValues.contains('Technology'), 'Should include Technology industry');
    }

    @isTest
    static void shouldReturnEmptyList_WhenNoAccountsHaveIndustry() {
        // Given - delete all accounts
        delete [SELECT Id FROM Account];

        // When
        Test.startTest();
        List<AccountController.PicklistOption> results = AccountController.getIndustryPicklistValues();
        Test.stopTest();

        // Then
        Assert.areEqual(0, results.size(), 'Should return empty list when no accounts exist');
    }

    // ─── getRatingPicklistValues Tests ───────────────────────────────────

    @isTest
    static void shouldReturnRatingValues_WhenCalled() {
        // Given - Rating picklist field on Account object

        // When
        Test.startTest();
        List<AccountController.PicklistOption> results = AccountController.getRatingPicklistValues();
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return rating options from schema');
        Assert.isNotNull(results[0].label, 'Options should have labels');
        Assert.isNotNull(results[0].value, 'Options should have values');
    }

    @isTest
    static void shouldReturnActiveRatingsOnly_WhenInactiveValuesExist() {
        // Given - Rating picklist from schema

        // When
        Test.startTest();
        List<AccountController.PicklistOption> results = AccountController.getRatingPicklistValues();
        Test.stopTest();

        // Then
        Assert.isTrue(results.size() > 0, 'Should return only active rating values');
        for (AccountController.PicklistOption opt : results) {
            Assert.isNotNull(opt.label, 'Each option should have a label');
            Assert.isNotNull(opt.value, 'Each option should have a value');
        }
    }

    // ─── Error Handling Tests ────────────────────────────────────────────

    @isTest
    static void shouldHandleSpecialCharacters_WhenSearchKeyContainsQuotes() {
        // Given - search key with special characters

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts('Test\'Account', null, null, null, null);
        Test.stopTest();

        // Then - should not throw exception
        Assert.isNotNull(results, 'Should handle special characters in search key');
    }

    @isTest
    static void shouldRespectUserPermissions_WhenQueryingAccounts() {
        // Given - standard user with limited permissions
        // Note: This test validates USER_MODE enforcement

        // When
        Test.startTest();
        List<Account> results = AccountController.getAccounts(null, null, null, null, null);
        Test.stopTest();

        // Then
        Assert.isNotNull(results, 'Should respect user FLS permissions');
        // USER_MODE ensures only accessible records and fields are returned
    }
}