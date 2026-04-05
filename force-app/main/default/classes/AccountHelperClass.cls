public class AccountHelperClass {
    
    public static boolean isFirstRun = True;
    
    public static void beforeInsert(List<Account> acList){			// Get the list
        System.debug('Account creation.');	
        String nm = acList[0].name;
        Account acc = new Account(Name = 'Another Account - '+nm);	// Prepared
        insert acc;													// Executed and invoked the respective trigger again
    }
    
    
    
    public static void beforeUpdate(List<Account> accList, Map<Id, Account> mapAccount){
        System.debug(accList);
        System.debug(mapAccount);
        
        Map<Id, Account> mpAcc = mapAccount;		// All Old values under Map
        
        if(Trigger.isExecuting){
            System.debug('Trigger Logic');
            for(Account newAc : accList){				// new values within List	// 1
                Account oldAc = mpAcc.get(newAc.Id);		// Old to compare			// 1
                
                if(newAc.AnnualRevenue < oldAc.AnnualRevenue){
                    newAc.AddError('Annual Revenue cannot be less that by its previous value.');
                }
                
            }
            System.debug('Execution Done.');
        }
        
        
    }
}