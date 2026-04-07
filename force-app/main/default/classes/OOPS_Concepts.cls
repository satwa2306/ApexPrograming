public with sharing class OOPS_Concepts {

    
    public   void state2(){
        
        system.debug('non-static');
    }
    
    public static void state1(){
        
       
        
        
        system.debug('static');
        
        //to check access modifer
       // OOPS.case1();
          
         integer a=10;
        
        /*Access modifier
         * global:access ouside the Org[integration purposes]
         * Pubilc:access within org
         * private:access within same class
         * protected:access within inherted class
         * 
         * /
       
      /*with sharing:retricts access as per record level and obect level security 
       * without sharing:by default,no retrictions
       * -----
       * 
       * static:the instance and execution will be same
       * Non static:execution can be done for each instance
       * 
       * static execution
       *----
       * OOPS_Concepts.state1();
       * 
       * nonstatic
       * -----
       * OOPS_Concepts o1= new OOPS_Concepts();
       * o1.state2(); 
       */ 
        
       
    }
    
   
}


/*
public with sharing class OOPs_Concept {
    
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
        
        //System.debug('OOPs Output Ended');
        
    

