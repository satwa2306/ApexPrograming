/**
 * Controller class for Account data retrieval with filtering capabilities.
 * Provides @AuraEnabled methods for Lightning Web Components to fetch and filter Account records.
 */
public with sharing class AccountController {

    // ─── Constants ───────────────────────────────────────────────────────
    private static final String ERROR_NULL_INPUT = 'Search parameters cannot be null.';
    private static final Integer DEFAULT_LIMIT = 200;
    
    // Base fields to query for all Account retrievals
    private static final String BASE_FIELDS = 'Id, Name, Industry, Phone, Website, AnnualRevenue, Rating, Type, NumberOfEmployees';

    // ─── Public API ──────────────────────────────────────────────────────

    /**
     * Retrieves Account records with optional filtering.
     * Supports filtering by Name (search text), Industry, Rating, and Annual Revenue range.
     * 
     * @param searchKey Text to search in Account Name (supports partial match)
     * @param industry Filter by specific Industry value
     * @param rating Filter by specific Rating value
     * @param minRevenue Minimum Annual Revenue filter
     * @param maxRevenue Maximum Annual Revenue filter
     * @return List of Account records matching the filter criteria
     * @example
     * List<Account> accounts = AccountController.getAccounts('Acme', 'Technology', 'Hot', 1000000, 5000000);
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(
        String searchKey,
        String industry,
        String rating,
        Decimal minRevenue,
        Decimal maxRevenue
    ) {
        try {
            // Build dynamic SOQL query
            String query = buildAccountQuery(searchKey, industry, rating, minRevenue, maxRevenue);
            
            // Execute query with USER_MODE for FLS enforcement
            List<Account> accounts = Database.query(query, AccessLevel.USER_MODE);
            
            return accounts;
            
        } catch (QueryException e) {
            throw new AuraHandledException('Error fetching accounts: ' + e.getMessage());
        } catch (Exception e) {
            throw new AuraHandledException('Unexpected error: ' + e.getMessage());
        }
    }

    /**
     * Retrieves distinct Industry picklist values from existing Account records.
     * Used to populate the Industry filter dropdown in the UI.
     * 
     * @return List of PicklistOption wrappers containing label and value
     * @example
     * List<PicklistOption> industries = AccountController.getIndustryPicklistValues();
     */
    @AuraEnabled(cacheable=true)
    public static List<PicklistOption> getIndustryPicklistValues() {
        List<PicklistOption> options = new List<PicklistOption>();
        
        try {
            // Query distinct Industry values from existing records
            String query = 'SELECT Industry FROM Account WHERE Industry != NULL GROUP BY Industry ORDER BY Industry ASC LIMIT 200';
            List<AggregateResult> results = Database.query(query, AccessLevel.USER_MODE);
            
            // Convert to PicklistOption format for LWC
            for (AggregateResult ar : results) {
                String industryValue = String.valueOf(ar.get('Industry'));
                if (String.isNotBlank(industryValue)) {
                    options.add(new PicklistOption(industryValue, industryValue));
                }
            }
            
        } catch (QueryException e) {
            System.debug(LoggingLevel.ERROR, 'Error fetching industries: ' + e.getMessage());
            // Return empty list on error rather than throwing
        }
        
        return options;
    }

    /**
     * Retrieves Rating picklist values from Account object schema.
     * Used to populate the Rating filter dropdown in the UI.
     * 
     * @return List of PicklistOption wrappers containing label and value
     * @example
     * List<PicklistOption> ratings = AccountController.getRatingPicklistValues();
     */
    @AuraEnabled(cacheable=true)
    public static List<PicklistOption> getRatingPicklistValues() {
        List<PicklistOption> options = new List<PicklistOption>();
        
        try {
            // Get Rating field schema
            Schema.DescribeFieldResult fieldResult = Account.Rating.getDescribe();
            List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
            
            // Convert to PicklistOption format for LWC
            for (Schema.PicklistEntry entry : picklistEntries) {
                if (entry.isActive()) {
                    options.add(new PicklistOption(entry.getLabel(), entry.getValue()));
                }
            }
            
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error fetching rating values: ' + e.getMessage());
            // Return empty list on error rather than throwing
        }
        
        return options;
    }

    // ─── Private Helpers ─────────────────────────────────────────────────

    /**
     * Builds a dynamic SOQL query string based on provided filter criteria.
     * Applies security with WITH USER_MODE and includes proper binding.
     * 
     * @param searchKey Name search text
     * @param industry Industry filter value
     * @param rating Rating filter value
     * @param minRevenue Minimum revenue filter
     * @param maxRevenue Maximum revenue filter
     * @return Complete SOQL query string
     */
    private static String buildAccountQuery(
        String searchKey,
        String industry,
        String rating,
        Decimal minRevenue,
        Decimal maxRevenue
    ) {
        String query = 'SELECT ' + BASE_FIELDS + ' FROM Account';
        List<String> conditions = new List<String>();
        
        // Add Name search condition with wildcard
        if (String.isNotBlank(searchKey)) {
            String searchPattern = '%' + String.escapeSingleQuotes(searchKey) + '%';
            conditions.add('Name LIKE \'' + searchPattern + '\'');
        }
        
        // Add Industry filter
        if (String.isNotBlank(industry)) {
            conditions.add('Industry = \'' + String.escapeSingleQuotes(industry) + '\'');
        }
        
        // Add Rating filter
        if (String.isNotBlank(rating)) {
            conditions.add('Rating = \'' + String.escapeSingleQuotes(rating) + '\'');
        }
        
        // Add Annual Revenue range filters
        if (minRevenue != null) {
            conditions.add('AnnualRevenue >= ' + minRevenue);
        }
        
        if (maxRevenue != null) {
            conditions.add('AnnualRevenue <= ' + maxRevenue);
        }
        
        // Combine all conditions
        if (!conditions.isEmpty()) {
            query += ' WHERE ' + String.join(conditions, ' AND ');
        }
        
        // Add ordering and limit
        query += ' ORDER BY Name ASC LIMIT ' + DEFAULT_LIMIT;
        
        return query;
    }

    // ─── Inner Classes ───────────────────────────────────────────────────

    /**
     * Wrapper class for picklist options.
     * Used to return picklist values in a format consumable by LWC combobox.
     */
    public class PicklistOption {
        @AuraEnabled public String label { get; set; }
        @AuraEnabled public String value { get; set; }
        
        public PicklistOption(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }
}