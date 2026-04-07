public class MyFirstApexClass {
    public static void myMethod(){
        System.debug('Hello World..!');
        System.debug('Code Updated');
        
        // Single Line Comment
        /*
			Multi Line Comments
		*/
        
        // Rules for Variables:
        // datatype VariableName = value
        // 1. Spaces not allowed
        // 2. must start with _, can only be between the characters
        // 3. cannot used reserved keywords
        // 4. meaning names to be used
        // 5. camel casing
        // 6. 
        // 
        
        integer i2 = 6;
        //System.debug();
        //
        
        // Constant - use final keyword
        final integer i4;
        System.debug(i4);				// null, empty, undefined, RunTime-error, other, don't know
        i4 = 200;			// ??
        System.debug(i4);				// RunTime-error, 200, other, don't know
        
        // i4 = 100;					// Error
        // System.debug(i4);
        
        integer i3 = 2+4;
    }
}