trigger triggerfirst on Account (before insert, After Insert, before update, After Update, before delete, After Delete, After Undelete) {
    
    if(Trigger.isBefore && Trigger.isInsert){								// Yes
        if(AccountHelperClass.isFirstRun){					// True			// False, will not go inside the condition
            
            AccountHelperClass.isFirstRun = False;			// False
            AccountHelperClass.beforeInsert(Trigger.new);	// Call
        	System.debug('Done.');
            
        }
        
        
    }
    
    
    
    if(Trigger.isBefore && Trigger.isUpdate){
        // Before Update
        // Trigger.oldMap and Trigger.newMap
        // Check if Account.AnnualRevenue is less that its previous value, then Throw error.
        //A> Prev. AR = 100000
        // New AR = 90000
        // Throw Error
        
        //B> Prev. AR = 100000					EdgeComm..
        //New AR = 110000						EdgeComm..
        //No Error
        
        AccountHelperClass.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
    
    
    
    
    

}