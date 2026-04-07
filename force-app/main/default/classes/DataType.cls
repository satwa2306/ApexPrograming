public class DataType {
    public static void myMethod(){
        // Premitive Data Types
        // Integer, String, Boolean, Long, Double, Decimal, Date, Time, DateTime, Id, Blob
        
        // Non-Pre Data Types
        // Arrya, Class, Interface
        
        // Syntax
        // datatype variableName;
        // dataType variableName = value;
        
        integer i = 2147483647;			// Max
        System.debug(i);
        
        System.debug(i+2);				// 2147483648, RunTimeError, Null, Undefined, Empty
        
        Long l = i+2L;
        System.debug(l);				// 2147483649
        
        /*
        // Floating Point
        // Double & Decimal
        double d = 9.980;
        System.debug(d);				// 9.980
        
        decimal d1 = 9.980;				// Currency
        System.debug(d1);				// 9.980
        
        // String - only single quotations  ' '
        String st = 'Hello World';
        String st2 = 'Hello';
        System.debug(st);
        
        // Case Insensititve
        sYsTem.DeBuG(st2);
        
        // Boolean : TRUE & FALSE
        Boolean a;
        System.debug(a);			// True, False, Null, Undefined, Empty, 0
        
        Boolean a1 = TRUE;
        Boolean a2 = FALSE;
        System.debug(a1 +', '+a2);
        
        
        // ID
        // RecordId -> 15 digit and 18 digit
        
        Id i1 = '001g5000004rwA4AAI';	// 18
        ID i3 = '001g5000007mO5eAAE';
        System.debug(i1);
        
        Id i2 = '001g5000004rwA4';		// 15 -> CASESAFEID()
        System.debug(i2);				// 18 digit
        
        String st4 = '001g5011104rwA4';
        System.debug(st4);
        
        // Date
        Date dt1 = Date.Today();		// YYYY, MM, DD
        System.debug(dt1);
        
        
        Date dt2 = Date.newInstance(2025, 02, 28);
        System.debug(dt2);
        
        // Time
        Time t1 = Time.newInstance(10, 64, 46,000);	// H, M, S.Ms
        System.debug(t1);			// 11:04:46.000
        
        // DateTime
        DateTime dt101 = DateTime.now();
        system.debug(dt101);
        
        DateTime dt102 = System.now();
        System.debug(dt102);
        
        dt102 = dt102.addHours(5);
        dt102 = dt102.addMinutes(30);
        System.debug(dt102);
        
        
        // Blob
        
        String st101 = 'Hello World';
        Blob b = Blob.valueOf(st101);
        System.debug(b);
        
        String st102 = b.toString();
        System.debug(st102);
        
        
        
        // sObject and Generic sObject
        // sObject = Salesforce Object
        // Account, Contact, Leads, Cases, Opp, Product etc...
        
        // Syntax
        // sObject variableName / objectName = new sObject();
        // Class objectName / instanceName = new Class();
        
        // Standard Object
        Account acc = new Account();			// individual record
        System.debug(acc);			// Null, Empty, Undefined
        
        acc.Name = 'Prateek Jain';
        acc.NumberOfEmployees = 1000;
        acc.AnnualRevenue = 100000;
        System.debug(acc);
        
        Account acc2 = new Account();			// another record 
        
        
        // Custom Object
        Student__c stud1 = new Student__c();
        System.debug(stud1);
        
        stud1.Student_Name__c = 'Aman Sharma';
        stud1.Aadhar_Card_Number__c = '988078672341';
        stud1.Stream_Opted__c = 'Salesforce';
        
        System.debug(stud1);

        // Account acc10101 = new COntact();		// ERROR


		// Generic sObject
		
        sObject s1;
        s1 = new Account(Name = 'S2Labs Pvt Ltd');
        System.debug(s1);
        
        
        s1 = new Contact(LastName = 'Jain', FirstName = 'Prateek');
        System.debug(s1);
        
        
        s1 = new Student__c(Student_Name__c = 'Aman Sharma');
        System.debug(s1);
        System.debug('Done');
*/
    }
}