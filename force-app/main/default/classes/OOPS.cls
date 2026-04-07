public class OOPS {

 public void myMethod2(Integer i){
        System.debug('Non-Static Method - '+i);
    }
    
    public static void myMethod(Integer j){
        System.debug('Output - '+j);
        
        /*Access Modifiers
		- Global	: accessible outside the Org. as well. [used for integration purposes]
		- Public	: accessible within the whole org.
		- Protected	: accessible within the inherited class.
		- Private	: accessible within the same class only.
		
		*/
        
        /*
         * User1 -> Account : CRUD, Opp : CRUD
         * User2 -> Account : CRU, Opp : No Access
         * OWD - Private
         * 
         *related to record level security
		with sharing	: restrictions will be implemented 
		without sharing	: By Default, User2 tried to access record of Opp, that user will be able to access those records.
		*/
        
        /*
		Static		: the instance or execution will be same
		Non-Static	: execution can be done for each instance
		*/
        
        /*
			Interface :- 
				A			B
				|			|
				----> C <----

			implements

		*/
        
        
        
        // MyFirstApexClass.myMethod();
        
        System.debug('OOPs Output Ended');
        
    }
}