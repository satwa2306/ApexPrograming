// DatabaseClasses - What, Why, How
// Transaction & Rollback
// LeadConvert
// ResultClasses


public class DML_DB_Classes {
    
    // Result Classes
    public static void rcMethod(){
        List<Account> aList = new List<Account>{
            new Account(Name='Test Account26'),				// Success
            new Account(Name='Test Account27'),				// Success
            new Account(Name='Test Account28'),				// Success
            new Account()									// Error
        };
        
        Database.SaveResult[] sr = Database.insert(aList, false);				// Sucess:Error
        System.debug(sr);
        
        for(Database.SaveResult result : sr){			// 0, 1, 2, 3
            System.debug(result);
            if (result.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + result.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : result.getErrors()) {		// 0, 1
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
        
        
        
        // Result Classes
        /*
		1. Database.insert() ->	Database.SaveResult[]
		2. Database.update() -> Database.SaveResult[]
		3. DataBase.upsert() -> Database.UpsertResult[]
		4. Database.Delete() -> Database.DeleteResult[]
		5. Database.Undelete() -> Database.UndeleteResult[]
		6. Database.Merge() -> Database.MergeResult[]
		7. Database.ConvertLead() -> Database.LeadConvertResult[]
		8. DataBase.EmptyRecycleBin() -> Database.EmptyRecycleBinResult[]
		
		*/
        
    }
    
    
    
    
    // Automatic conversion of Lead
    // Database.LeadConvert()
    
    public static void lcMethod(){
        Lead l = new Lead(LastName='Gupta', Company='Cyntexa Labs', AnnualRevenue=400000, NumberOfEmployees=1000, Rating='Cold', Industry='Banking');
        
        Database.insert(l);
        
        System.debug(l);
        
        // do setup to directly convert the lead.
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(l.Id);
        
        // lc.setAccountId(); -> If we want to link this lead to any existing Account Record
        // lc.setContactId(); -> If we want to link this lead to any existing Contact Record
        
        lc.setDoNotCreateOpportunity(True);		// True[Default]
        lc.setConvertedStatus('Closed - Converted');
        
        Database.convertLead(lc);
        System.debug(lc);
    }
    
    
    // Transaction and Rollback
    // Savepoints
    public static void trMethod(){
       
      insert new Account(Name='Before 1st SavePoint');  
        
       Savepoint sp1 = Database.SetSavePoint();
       
       insert new Account(Name='After 1st SavePoint');
        
        
       Savepoint sp2 = Database.SetSavePoint();
       insert new Account(Name='After 2nd SavePoint');
        
       Database.rollback(sp1); 
       
        insert new Account(Name='After 1st Rollback');
    }
    
    
    // Database Classes and their result classes
    public static void dbMethod(){
        
        List<Account> accList = new List<Account>();
        for(integer i=22 ; i<25 ; i++){		// 22, 23, 24
            Account a1 = new Account(Name='Test Account'+i, NumberOfEmployees=1000+i);
            
            // insert a1; 
            // Best Practices, because of Governor Limits
            
            accList.add(a1);
        }
        
        accList.add(new Account());		// Error
        
        // insert accList;			// if you got the error in 13,16, 200, 258 record out of 1000, it will rollback the whole transaction automatically
        
        // Database.insert(sObject, All_OR_None);		// All or None is a boolean value
        // Database.insert(accList, false);
        
        
        // additional Operations
        // Database.update();
        // Database.upsert();
        // Database.delete();
        // Database.undelete();
        // Database.merge();
        
        
        // Database.emptyRecycleBin();
        List<Account> accListToDelete = [Select Name From Account where isDeleted=true ALL ROWS];
        // Database.emptyRecycleBin(accListToDelete);
        
        
    }
    
    
        // DML
    public static void myMethod(){
        /*
        Account a = new Account(Name='Test Account 1', NumberOfEmployees=1000);
        System.debug(a);
        
        // Operations
        // INSERT, UPDATE, UPSERT, DELETE, UNDELETE, MERGE
        
        // Which dataType field supports External Id functionality ? -> Email,  
        
        // 1. INSERT
        // syntax
        // insert sObjectVariableName / List<sObj>_VariableName
        
        // Single Record
        // insert a;
        System.debug(a);
        
        
        // Multiple/Bulk records
        List<Account> accList = new List<Account>();
        for(integer i=2 ; i<12 ; i++){
            Account a1 = new Account(Name='Test Account'+i, NumberOfEmployees=1000+i);
            
            // insert a1; 
            // Best Practices, because of Governor Limits
            
            accList.add(a1);
        }
        
        // insert accList;
        
        // Contact related to each Account name like - 'Test%'
        List<Contact> conList = new List<Contact>();
        // Exisiting Account
        List<Account> accList2 = [Select Name From Account Where Name Like 'Test%'];		// 11
        
        // New Account
        Account a11 = new Account(Name='Test Account 11');
        // insert a11;
        
        // Account ----<- Contact
        // Created for Existing records
        for(Account a2 : accList2){			// Test Account7
            Contact c = new Contact(lastName = a2.Name + ' - Contact', AccountId = a2.Id);	// Test Account7 - Contact
            
            conList.add(c);
        }
        
        // for New Record
        Contact c1 = new Contact(lastName = a11.Name+ ' - Contact', AccountId = a11.Id);
        conList.add(c1);
        
        // insert conList;
        */
        
        
        // 2. UPDATE
        /*
        List<Account> accList = [Select Name, NumberOfEmployees, Rating, AnnualRevenue From Account Where Name Like 'Test%'];		// 11
        for(Account a : accList){
            
            if(a.NumberOfEmployees==null){
                a.NumberOfEmployees = 0;
            }
            
            a.NumberOfEmployees += 2000;
            a.Rating = 'Cold';
            
            if(a.AnnualRevenue==null){
                a.AnnualRevenue = 0;
            }
            
            // 100
            a.AnnualRevenue += a.NumberOfEmployees+100000;
            // a.AnnualRevenue = a.AnnualRevenue + a.NumberOfEmployees + 100000;
            // ar = 100 + 3000 + 100000 = 103100
        }
        
        System.debug(accList);
        // update accList;
		*/

		// 3. UPSERT - conbination of Insert + Update
		/*
        List<Account> accList = [Select Name, NumberOfEmployees From Account Where Name Like 'Test%' limit 2];		// 2
        System.debug(accList);
        Account a = new Account(Name='Test Account 15');
        
        accList.add(a);
        
        for(Account a1 : accList ){
            if(a1.NumberOfEmployees==null){
                a1.NumberOfEmployees=0;
            }
            
            a1.NumberOfEmployees += 1000;
        }
        
        System.debug(accList);
        upsert accList;			// Update = 2, Insert = 1
		*/
        
        
        // 4. DELETE
        /*
        List<Account> accList = [Select Name, NumberOfEmployees From Account Where Name Like 'Test%' limit 2];
        System.debug(accList);
        Delete accList;
        System.debug(accList);
		*/
        
        
        // 5. UNDELETE
        /*
        List<Account> accList = [Select Name, NumberOfEmployees, isDeleted From Account Where isDeleted=true All Rows];
        System.debug(accList);
       	undelete accList;
        //System.debug(accList);
        */
        
        // 6. MERGE - combination of Update + Delete
        // A1 - C1, C2, C3, C4
        // A2 - delete, A3 - delete, A4 - delete [MAX.]
        // Max. 3 records at a time
        // syntax
        // merge sObjectVariable sObjectVar/List<sObj>Var
        List<Account> accList = [Select Name, NumberOfEmployees From Account Where Name='Test Account 1' or NAme = 'Test Account2'];
        
        System.debug(accList);
        
        Account a101 = accList[0];
        Account a102 = accList[1];
        
        List<Account> acMerge = new List<Account>();		// 3
        
        merge a101 acMerge;
        
    }
}