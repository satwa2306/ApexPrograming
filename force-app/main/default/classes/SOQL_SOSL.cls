public class SOQL_SOSL {
	// similar to SQL
	// Select * From TableName
	// SOQL - Salesforce Object Query Language
	
   	// Syntax
    // Select ColumnName1, ColumnName2... From objectName;    
    // select field_API_Name from object_API_Name
    
    
    
    public static void myMethod(String n){
        // Standard Object
        // System.debug([Select Name From Account]);
        /*
        List<Account> accList = [Select Name From Account];		// 5
        System.debug(accList);	// all 5
        
        // for(dataType variableName : listName){}
        for(Account acc : accList){
            System.debug(acc);			// 1, 2, 3, 4, 5
        }
        */
        
        
        // Custom Object
        // __c :- either Object or Field
        
        // System.debug([Select Student_Name__c From Student__c]);
        /*
        List<Student__c> stList = [SELECT Id, Student_Name__c, Student_Email_Id__c, Student_Contact_Number__c FROM Student__c];
        System.debug(stList.size());    
          
        for(Student__c st : stList){
            //System.debug(st);
        }
        
        for(integer i = 0 ; i<stList.size() ; i++){
            System.debug(stList[i]);
        }
		*/
        
        // Method of SOQL
        // 1. Where - whole records, for individual Row
        // 2. AND
        // 3. OR
        // 4. Aggregate Function - SUM, MIN, MAX, COUNT, AVG
        // 5. Group By - Having : for individual column
        // 6. Order By - ASC, DESC, Nulls Last
        // 7. Limit
        // 8. offSet
        // 
        
        // IN, Like, Wildcards, AllRows, VariableBinding
        
        
        // 9. IN along with VariableBinding
        
        // Fetch record where name into a particular collection.
        List<String> stList = new List<String>{'Edge Communications', 'S2Labs', 'Cyntexa Labs', 'SBI Bank'};
        
        List<Account> accList = [Select Name, NumberOfEmployees, Rating, AnnualRevenue From Account Where Name IN :stList];
        // System.debug(accList);
        // System.debug(accList.size());
        
        // 10. Like along with wildCards
        // Fetch account records, where 'ab' names into their name
        // WildCards - 
        // 		_ individual character
        // 		% 0 to n characters
        List<Account> accList2 = [Select Name From Account Where Name LIKE '%ab%'];
        // System.debug(accList2);
        
        // 11. All Rows
        // fetch records which are deleted as well
        List<Account> accList3 = [Select Name, isDeleted From Account Where isDeleted=true all rows];
        // System.debug(accList3);
        
        
        // Relationship Query
        // 1. Child to Parent -: Done with the help of 'dot Notation'
        
        // a. Standard Object
        // [Select Name, Relationship_FieldName.ParentFieldName  from ChildObjectName]
        // Account ----<- Contact
        List<Contact> conList = [Select Name, FirstName, LastName, Account.Name, Account.AnnualRevenue From Contact];
        
        // b. customObject
        // [Select Name, Relationship_FieldName__r.ParentFieldName__c  from ChildObjectName__c]
        // Student__c ----<- Rating__c
        
        //List<Rating__c> rtList = [Select Name, Select_Student__r.Student_Name__c, Select_Student__r.Student_Email_Id__c From Rating__c];
        
        
        // 2. Parent to Child -: Done with the help of 'sub Query', max. 20 subQuery within a Parent Query, but not works for MultiLevel subQuery
        
        // a. Standard Object
        // [Select ParentObjectFields, (Select childObjectFields From ChildRelationship_Field_Name) From ParentObjectName]
        // Account ----<- Contact
        // Fetch all the account records with their associated contact records
        List<Account> accList5 = [Select Name, (Select firstName from Contacts) From Account Limit 2];
        // System.debug(accList5);
        for(Account ac : accList){
            // System.debug(ac);
            // System.debug('Name - ' +ac.Name);
            // System.debug(ac.Contacts);
        }
        
        // b. Custom Object
        // [Select ParentObjectFields__c, (Select childObjectFields__c From ChildRelationship_Field_Name__r) From ParentObjectName__c]
        // Student__c ----<- Rating__c
        // Fetch all the students records with their associated rating records
        //List<Student__c> stList2 = [Select Student_Name__c, (Select Name, Rating_for__c, Rating_out_of_10__c From Ratings__r) From Student__c];
        
        
    }
    
    
    // SOSL - Salesforce Object Search Language
    // Can fetch record from multiple objects together
    // {Find 'What' [WhatType] Returning [Where]}
    // dataType - sObject
    // List<List<sObject>>
    //List<List<sObject>> l1 = [Find 'SBI' Returning Account(Name, NumberOfEmployees), Contact(FirstName, LastName), Student_in_Batch__c];
    
    //List<Account> acList = l1[0];
    // System.debug(acList);
    //List<Contact> cList = l1[1];
    // system.debug(cList);
    // List<Student_in_Batch__c> = l1[2]; -> Need to check
    
    // Search Groups
    // 1. All Fields - default 
    // 2. Name Fields 
    // 3. Email Fields
    // 4. Phone Fields
    // 5. Sidebar Fields
}

// SOQL						SOSL
// Specific Object			any object
// List<sObject>			List<List<sObject>>
// all the fields			Search groups
// Count()					not used 
// Single object			multiple objects
// DML						not possible
//