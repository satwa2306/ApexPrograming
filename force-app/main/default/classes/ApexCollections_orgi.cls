public class ApexCollections_orgi {
public static void myMethod(){
        // integer i = 2,3,4,5;
        
        // Collection
        // List, Set and Map
        
        
        /* LIST */
        // Indexing
        
        /*
        
        // Syntax
        // List<dataType> variableName = new List<dataType>();
        List<Integer> iList = new List<Integer>();
        system.debug(iList);									// null, empty, undefined ?
        
        
        // List Methods
        // 1. add(element) - to add values into a list
        iList.add(5);
        iList.add(3);
        iList.add(1);
        iList.add(4);
        iList.add(2);
        System.debug(iList);
        System.debug(iList[3]);				// 4
        
        // 2. size() - to get total elements into the list
        System.debug('Size of List = ' + iList.size());
        
        // 3. get(index) - to get the value of a specific index
        System.debug('On index 3 value is - '+ iList.get(3));
        
        // 4. remove(index) - to remove the value of a specific index
        iList.remove(3);				// 4
        system.debug('List of values after removing index 3 value = ' +iList);
        
        // Additional
        
        List<Integer> iList3 = new List<Integer>();
        iList3 = iList;							// Pass by reference
        System.debug(iList3);					// 5,3,1,2
        
        // 5. clone() - to make a duplicate of a list
        List<Integer> iList2 = new List<Integer>();
        iList2 = iList.clone();					// Pass by value
        System.debug('Values in new List - ' + iList2);				// 5,3,1,2
        
        iList.add(4);												// 5, 3, 1, 2, 4
        System.debug(iList);
        System.debug(iList2);
        System.debug('iList3 = '+ iList3);
        
        
        // 6. set(index, value) - override the value on a specific index
        iList.set(2, 10);
        System.debug(iList);
        
        // 7. sort() - to arrange the values in an order
        iList.sort();
        System.debug('Sorted list = ' + iList);
        
        // 8. isEmpty() - to check and returns TRUE is the list is empty .
        // 9. clear() - remove all the elements from the list, or to make the list an empty list.
        
        System.debug('List2 is empty [Before] ? - '+ iList2.isEmpty());
        
        iList2.clear();
        System.debug('List2 is empty [After] ? - '+ iList2.isEmpty());
        
        
        
        
        // List Array Notations
        
        // 1.
        Integer[] i = new Integer[4];		// fixed size will be of 4 elements only
       	
        // 2. 
        Integer[] i2 = new List<Integer>();	// dynamic size
        
        // 3. 
        List<Integer> i3 = new Integer[4];	// fixed size of 4
        
        // 4. 
        List<Integer> i4 = new List<Integer>(); // fully dynamic
        
        Account acc = new Account(Name='S2Labs', NumberOfEmployees=1000);
        System.debug(acc);
        
        List<Integer> i5 = new List<Integer>{1, 2, 3, 4, 5};
        System.debug(i5);
        
        
        // Nested List
        // List inside a list
        // [[1, 2, 3], [0, 0, 0], [11, 22, 33], [111, 222, 333]]
        List<Integer> int1 = new List<Integer>{1, 2, 3};
        List<Integer> int2 = new List<Integer>{11, 22, 33};
        List<Integer> int3 = new List<Integer>{111, 222, 333};
            
        List<List<Integer>> nestedList = new List<List<Integer>>{int1, 
            new List<Integer>{0, 0, 0}    
        };
        nestedList.add(int2);
        nestedList.add(int3);
        
        System.debug(nestedList);
        */
        
        
        
        
        /* SET */
        // UnOrdered
        
        // Syntax
        // Set<dataType> variableName = new Set<dataType>();
        // Set<dataType> variableName = new Set<dataType>{value1, value2 ...};
        
        /*
        
        Set<Integer> iSet = new Set<Integer>{10, 20, 4, 5, 3, 25, 56, 23, 34, 4, 5, 10, 34};
        System.debug(iSet);
        
        // Method
        // 1. size()
        System.debug('Size of Set = ' + iSet.size());
        
        // 2. add()
        iSet.add(19);
        System.debug(iSet);
        
        List<Integer> i5 = new List<Integer>{1, 2, 3, 4, 5};
        System.debug(i5);
        
        // 3. addAll(set/List)			// also be used in List
        iSet.addAll(i5);
        System.debug(iSet);
        
        // 4. clone() - same as List, copy
        // 5. clear() - same as List
        // 6. isEmpty() - same as List
        // 7. remove(element) - same as List
        
        // 8. contains(value)
        System.debug(iSet.contains(10));
        
        // 9. containsAll(set/List)
        system.debug(iSet.containsAll(i5));
        
        // 10. retainAll(set/List)
        iSet.retainAll(i5);
        System.debug(iSet);
        
        Set<Account> accSet = new Set<Account>{
            new Account(Name='Amazon', NumberOfEmployees = 1000),
            new Account(Name='Flipkart'),
            new Account(Name='Amazon', NumberOfEmployees = 1200)
        };
        System.debug(accSet);
        */
        
        
        /* MAP */
        // Key-Value pair
        
        // Student data
        // RollNo		Name
        // 101			Aman
        // 102			Raman
        // 105			Pawan
        // 104			Naman
        // 105			Aman
        
        // Key - always be unique
        // Values - can be duplicate
        
        // Syntax
        // Map<keyDataType, valueDataType> variableName = new Map<keyDataType, valueDataType>();
        
        /*
        Map<Integer, String> stData = new Map<Integer, String>();
        
        
        // Method
        
        // 1. put(key, value)
        stData.put(101, 'Aman');
        stData.put(104, 'Raman');
        stData.put(105, 'Paman');
        stData.put(102, 'Naman');
        stData.put(105, 'Aman');
        
        System.debug(stData);
        
        // 2. putAll(map)
        Map<Integer, String> stData2 = new Map<Integer, String>();
        stData2.putAll(stData);
        System.debug(stData2);
        
        // 3. get(key)
        System.debug(stData.get(104));			// Naman
        
        // 4. values()
        System.debug(stData.values());
        
        List<String> stNames = stData.values();
        System.debug('List of names from Map - ' +stNames);
        
        // 5. keySet()
        system.debug('Key set of Map - '+ stData.keySet());
        Set<Integer> stRollNo = stData.keySet();
        System.debug('Key Set - '+stRollNo);
        
        // 6. clone - similar to list & set
        // 7. isEmpty - similar to list & set
        // 8. size - similar to list & set
        // 9. clear - similar to list & set
        
        // 10. remove(key) - similar to list & set
        // 11. contains(key) - similar to set

		*/
        

		// Conditional Statements
		integer a = 100;
		// if
        if(a>50){
            System.debug('Yes');
        }        
        
        // if-else
        if(a>50){
            System.debug('Yes');
        }else{
            SYstem.debug('No');
        }
        
        // if-else if - .. else
        
        if(a>50){
            System.debug('Yes');
        }else if(a>30){
            SYstem.debug('Moderate');
        }else if(a>20){
         	System.debug(' Yes with 20');
        }else{
            SYstem.debug('No');
        }
        
        
        // nested if-else
        
        if(a>50){
            System.debug('Yes, with 50');
            if(a>75){
                System.debug('Yes with 75 as well');
            }else{
                SYstem.debug('No, but only with 50');
            }
        }else{
            SYstem.debug('No, not with 50');
            if(a>30){
                System.debug('Yes, with 30');
            }else{
                SYstem.debug('No, not with 30 as well');
            }
        }
        
    }
}