public with sharing class OOPS_Concepts {

    
    public   void state2(){
        
        system.debug('non-static');
    }
    
    public static void state1(){
        
        
        system.debug('static');
        
        //to check access modifer
        OOPS.case1();
          
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