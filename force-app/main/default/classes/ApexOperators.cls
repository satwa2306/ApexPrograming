public class ApexOperators {
    public static void myMethod(){
        
        // Looping Statement
        // for, do-while, while, for-each
        
        // 1. for loop
        integer val = 5;
        System.debug('For Loop : ');
        for(integer i=1 ; i<11 ; i++){
            System.debug(i +' X 5 ='  + val*i );
        }
        
        // 2. while loop
        integer i = 1;
        System.debug('While Loop : ');
        while(i<11){
            System.debug(i +' X 5 ='  + val*i );
            i++;
        }
        
        // 3. Do-While
        i = 1;
        System.debug('Do-While Loop');
        do{
            System.debug(i +' X 5 ='  + val*i );
            i++;
        }while(i<11);
        
        
        // 4. For-Each loop
        System.debug('For-Each Loop');
        List<Integer> iList = new List<integer>{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        for(Integer i1 : iList){
            System.debug(i1 +' X 5 ='  + val*i1 );
        }
        
        Set<Integer> iSet = new Set<Integer>{1, 2, 3, 4, 5, 4, 3, 2, 1, 5, 6, 7, 8, 9, 8, 7, 6, 5, 10};
        for(Integer i1 : iSet){
            System.debug(i1);
        }
        
        /*
        // Arithmetic, Logic, Assignment, Comparision, Increment/Decrement
        
        // Operators in Apex - 
        // 1. Add/Sub : +, -
        integer a = 10;			// 10
        integer b = a + 5;		// 15
        
        integer c = b - 2; 		// 13
        System.debug(a +' & ' + b + ' & ' + c);
        
        String s1 = '10';		// 10
        String s2 = s1 + a;		// 20, 10, runTimeError, null, undefined, 1010, empty
        System.debug(s1 +' & ' + s2);
        
        
        Date dt = Date.newInstance(2026, 03, 02);
        Date dt1 = dt + 5;
        
        System.debug(dt1);
        
        DateTime dTime = DateTime.newInstance(2026, 03, 02, 10, 12, 30);
        DateTime dTime2 = dTime + 51.2;
        
        System.debug(dTime2);
        // 02 + 5 = 07
        // 0.2 = 20% of 24hours	= 4.8
        // each 0.1 = 2 hours 24min
        // 
        // 4hours and 0.8
        // 0.8 = 80% of 60min	= 48min
        // 4hours 48min
        // 15 hours 0 min 30 sec
        // - 5hours 30min
        // 09 hours 30min 30 sec
        
        // 2. Shorthand Operators
        // +=, -=, *=, /=
        a += 25;					// a = a + 25;
        System.debug(a);			// 35
        
        // 3. Logical Operators
        // &, |, !
        if((a>5) & (b>10)){
            System.debug('AND Operator');
        }
        
        // 4. Equality Operator					// Inequality operator
        // ==									// !=
        // String
        String st1 = 'Hello';
        String st2 = 'Hello';
        
        System.debug(st1==st2);
        
        // ID - both need to be exact same
        // List or Array
        List<Integer> aList = new List<integer>{1, 2, 3, 4, 5};
        List<Integer> bList = new List<integer>{1, 2, 3, 4, 5};
        
		System.debug(aList == bList);
        
        // 5. Exact Equality Operator			// Exact Inequality
        // ===									// !==
        
        MyFirstApexClass abc = new MyFirstApexClass();
        MyFirstApexClass abc2 = abc;
        if(abc === abc2){
            System.debug('True');
        }else{
            System.debug('FALSE');
        }
        
        
        // 6. Relational Operators
        // <, >, <=, >='
        
        // BODMAS
        // B - Brackets
        // O - Operators
        // D - Division
        // M - Multiplication
        // A - Addition
        // S - Substraction
        
        
        // Conditional Statement
        // - Shorthand If
        // Syntax
        // variable = (condition) ? expressionTrue : expressionFalse;
        
        Integer value = 5>7 ? 10 : 20;
        System.debug(value);
        
		*/
    }
}