public class ExceptionHandling {
    
    /*
		Governor Limits 

	*/
    
    
    
    public static void myMethod(){
        // System Defined
        // 		- DML Exception
        // 		- SOQL Exception
        // 		- NullPointer Exeption
        // 		- String Exception
        // 		- Final Exception
        // 		- Query Exception
        // 		- sObject Exception
        // 		- List Exception
        // 		- 
        // Custom/User Defined
        // 		- Generic Exception
        
        try{
            integer a;
        	// integer b = a * 5;			// NullPointerException
            // System.debug(b);
        
            // Account acc = [Select Name From Account Where Name Like 'Test%'];			// QueryException
            
            List<Account> acList = [Select Name From Account Limit 2];
            //System.debug(acList[2]);						// List Exception
          	
            
            // System.debug(acList[0].NumberOfEmployees);				// sObject Exception
            
            // insert new Account();						// DML Exception
            
            final integer a101;
            a101 = 2000;
            // a101 = 3000;			// FinalException
            // 
            
            
            MyCustomException mce = new MyCustomException('From CE');
            
            
            
            System.debug('All Exception Done.');
            throw mce;
        }catch(NullPointerException e){
            System.debug('Null Pointer Exception.');
            System.debug(e);
        
        }catch(QueryException e){
            System.debug('Query Exception.');
            System.debug(e);
            
        }catch(ListException e){
            System.debug('List Exception.');
            System.debug(e);
            
        }catch(DMLException e){
            System.debug('DML Exception.');
            System.debug(e);
            
        }catch(sObjectException e){
            System.debug('sObject Exception.');
            System.debug(e);
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
            System.debug(e.getStackTraceString());
            System.debug(e.getCause());
            System.debug(e.getTypeName());
            
        }catch(FinalException e){
            SYstem.debug('General Exception');
            System.debug(e);
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
            System.debug(e.getStackTraceString());
            System.debug(e.getCause());
            System.debug(e.getTypeName());
            
        }catch(Exception e){
            System.debug('Generic Exception');
            System.debug(e);
            System.debug(e.getMessage());
            
        }
        
        
        
        
        
        
    }
}