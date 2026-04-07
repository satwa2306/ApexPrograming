public class person {
    
    
    public person()
    {
        
        system.debug('default contructor');
    }
    
    //parameterized constuctor
    
    public person(integer a, string b){
        
        integer name=a;
        string  address=b;
            
        system.debug('name');
    }

     public static string address;
    
     public string name;
    
     public integer age;
    
   /* person p1=new person();
    *p1.name='rajesh';
    *p1.address='india';--static variable
    cannot call static variable from non static//Static field cannot be referenced from a non static context: address from the type person
   */
    public static void v1(){
        
        person p1=new person();
        p1.name='rajesh';
        system.debug(address);
         system.debug(p1);
        
        //system.debug(name);
        //simalry cannot call non static variable fron static method
        
    }
    
      
    public void  v2(){
        
        system.debug('non-static');
        
        system.debug(name);
        system.debug(address);
        //static variable can be called from static and static method,But non-static variable cannot call it from static method
        
    }
    
    //default contructor
    //
    //
}


/*public class Person {
    
    public Person(){
        System.debug('Default Constructor');
        
    }
    
    // Parametrized Constructor
    public Person(string n, integer i, string c, string ad){
        this.Name = n;
        this.Age = i;
        this.City = c;
        Address = ad;
    }
    
    
	public string Name;
    public integer age;
    public string city;
    
    public static string Address;
    
    public static void myMethod(){
        System.debug('Static Method');
        
        // System.debug(name);		 // ERROR
        System.debug(address);
        
    }
    
    public void myMethod2(){
        System.debug('Non-Static Method');
        
        System.debug(name);		 // null or Prateek
        System.debug(address);
        
    }
}
*/