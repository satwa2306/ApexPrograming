Public class Asynchronous_apex implements database.Batchable<sObject>,database.stateful, Schedulable {

    /*batch apex-bulk records(max limit 2000 records to default-200)
     * schedule apex
     * queueble apex
     * future apex
     * 
    */
    
    
    public void execute(SchedulableContext sc){
        system.debug('scheduable excute method run');
        
          
          list<Account> acs = [select annualRevenue,Name from Account limit 2];	
          Asynchronous_apex ap =new Asynchronous_apex(acs);

         database.executeBatch(ap);
        
    }    
    
    public List<Account> inputAccounts=new list<account>();

    public Asynchronous_apex(List<Account> acs){
        this.inputAccounts = acs;
    }
    public integer count=0;
    
    public DataBase.QueryLocator Start(Database.BatchableContext sb){
        
        system.debug('start');
        system.debug('countstart '+count);
        return Database.getQueryLocator([Select name,annualRevenue from account]); //12/3
        
        
        }
    
    
    public void Execute(Database.BatchableContext sb, List<Account> accList){
         
        
        system.debug('Execute');
        system.debug('Accoountsize '+ accList.size());      
        //List<account> accList= new List<account>();
        
        list<contact> cc= new list<contact>();
        
        For(Account ac: accList){
            
            if(ac.AnnualRevenue == null){
                
                
                Contact clist= new contact(lastname=ac.Name + ' batchcontact' );
                
                //system.debug(clist);
                //list<contact> sr = new list<contact>();
				//sr.add(new contact(lastName='satwa'));                                  
                cc.add(cList);
                
                //system.debug(cc);
                }
            
                       
            
        }
        
         system.debug('contact size '+ cc.size());
         count++;
        //insert(cc);
        system.debug('countexcute '+count);
    }
    
    public void finish(Database.BatchableContext sb){
        system.debug('Finish');
        
        system.debug(sb);
        system.debug('countfinish '+count);
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                        // Set recipients to two contact IDs.
                        // Replace IDs with valid record IDs in your org.
                    //message.toAddresses = new String[] { 'kongarasatwalekar@gmail.com', 'kongarasatwik040403@gmail.com' };
                  message.setToAddresses(new List<String>{
    'kongarasatwalekar@gmail.com',
    'kongarasatwik040403@gmail.com'
});
                    //message.optOutPolicy = 'FILTER';
                    message.subject = 'gundu fello';
                    message.plainTextBody = 'borra fellow waste fellow';
                    Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        			      if (results[0].success) {
                        System.debug('The email was sent successfully.');
                    } else {
                        System.debug('The email failed to send: '
                              + results[0].errors[0].message);
                    }

        
    }
    
    

}

    /*Asynchronous_apex ap =new Asynchronous_apex();
     * Database.executeBatch(ap,3);
    /              

     */