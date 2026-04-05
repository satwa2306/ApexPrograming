trigger firstTrigger on Account (before insert) {

    /*
    // Once Account is created, link one Contact associated to it.
    Map<Id, Account> mpAcc = Trigger.newMap;		// 5
    
    List<Contact> conList = new List<Contact>();
    
    // System.debug();
    for(Id i : mpAcc.keySet()){
        Contact c = new Contact(lastName = 'New Contact - '+i, AccountId = i);
        conList.add(c);
    }
    System.debug(conList);
    insert conList;
    */
    
    
    /*
    // Trigger.old
    // Check if Account.AnnualRevenue is less that its previous value, then Throw error.
    //A> Prev. AR = 100000
    // New AR = 90000
    // Throw Error
    
    //B> Prev. AR = 100000					EdgeComm..
    //New AR = 110000						EdgeComm..
    //No Error
    
    for(Account acOld : Trigger.Old){			// 1, 2, 3
        for(Account acNew : Trigger.New){		// 1, 2, 3
            if( (acOld.Id == acNew.Id) && (acOld.AnnualRevenue > acNew.AnnualRevenue) ){
                acNew.AddError('Annual Revenue cannot be less that by its previous value.');
            }
        }
    }
    */
    
    
    
    // Non-Bulkified Record
    // Working on single record
    /*
    Account a = Trigger.new[0];
    a.NumberOfEmployees = 10101;
    Account a1 = Trigger.new[1];
    a1.NumberOfEmployees = 10101;
    Account a2 = Trigger.new[2];
    a2.NumberOfEmployees = 10101;
    Account a3 = Trigger.new[3];
    a3.NumberOfEmployees = 10101;
    Account a4 = Trigger.new[4];
    a4.NumberOfEmployees = 10101;
    */
    
    
    /*
    // Bulkified Record
    // woking on Bulk records
    for(Account ac : Trigger.new){
        ac.NumberOfEmployees = 5000;
    }
	*/
    
    
    
    /*
    
    // Trigger.new		-		Before Insert, After Insert, Before Update, After Update, After unDelete
    // Trigger.old		-		Before Update, After Update, Before Delete, After Delete
    // Trigger.newMap	-		After Insert, Before Update, After Update, After unDelete
    // Trigger.oldMap	-		Before Update, After Update, Before Delete, After Delete
    
    
    
    if(Trigger.isBefore){
        // BEFORE
        if(Trigger.isInsert){
            // Before Insert
            System.debug('This is before insert [New] - ' + Trigger.newMap);
            System.debug('This is before insert [Old] - ' + Trigger.oldMap);
            
        }else if(Trigger.isUpdate){
            // Before Update
            System.debug('This is before Update [New] - ' + Trigger.newMap);
            System.debug('This is before Update [Old] - ' + Trigger.oldMap);
            
        }else if(Trigger.isDelete){
            // Before Delete
            System.debug('This is before Delete [New] - ' + Trigger.newMap);
            System.debug('This is before Delete [Old] - ' + Trigger.oldMap);
            
        }
    }else{
        // AFTER
        if(Trigger.isInsert){
            // Before Insert
            System.debug('This is After Insert [New] - ' + Trigger.newMap);
            System.debug('This is After Insert [Old] - ' + Trigger.oldMap);
            
        }else if(Trigger.isUpdate){
            // Before Insert
            System.debug('This is After Update [New] - ' + Trigger.newMap);
            System.debug('This is After Update [Old] - ' + Trigger.oldMap);
            
        }else if(Trigger.isDelete){
            // Before Insert
            System.debug('This is After Delete [New] - ' + Trigger.newMap);
            System.debug('This is After Delete [Old] - ' + Trigger.oldMap);
            
        }if(Trigger.isUnDelete){
            // Before Insert
            System.debug('This is After UnDelete [New] - ' + Trigger.newMap);
            System.debug('This is After UnDelete [Old] - ' + Trigger.oldMap);
            
        }
    }
	*/

}