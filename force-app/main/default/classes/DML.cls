public class DML {
  //update
  public static void update1() {
    list<account> accupdate = [
      SELECT name, NumberOfEmployees
      FROM account
      LIMIT 1
    ];

    for (account accup : accupdate) {
      accup.NumberOfEmployees = 12;
    }
    system.debug(accupdate1);
    update accupdate;
  }

  //insert
  public static void insert1() {
    List<account> accint = new List<account>();
    for (integer i = 1; i < 5; i++) {
      account a2 = new account(Name = 'satwa' + i, NumberOfEmployees = 100 + i);
      system.debug(a2);
      accint.add(a2);
    }
    insert accint;
  }
  //upsert
  public static void upsert1() {
    list<account> a1 = new List<account>();

    account a2 = new account(Name = 'satwa5', NumberOfEmployees = 105);

    list<account> accon = [SELECT name FROM account WHERE name LIKE '%satwa%'];

    list<contact> c1 = new List<contact>();
    for (account accc1 : accon) {
      system.debug(accc1);
      contact c = new contact(
        LastName = accc1.Name + ' -conatcts',
        AccountId = accc1.Id
      );
      system.debug(c);

      c1.add(c);
    }
    upsert c1;
  }
  //delete
  public static void delete1() {
    list<account> accon = [
      SELECT name
      FROM account
      WHERE name LIKE '%satwa%'
      LIMIT 1
    ];
    system.debug(accon);
    delete accon;
  }

  //undelete
  public static void undelete1() {
    list<account> accon1 = [
      SELECT name
      FROM account
      WHERE isDeleted = TRUE
      ALL ROWS
    ];
    system.debug(accon1);

    undelete accon1;
  }

  //merge
  //combination of update and delete 
  //A1- C1,C2,C3,C4
    //A2-delete,A3-delete,A4-delete {MAX}
    //sytax
    //merge sObject
  public static void merge1() {
      
   list<account> accmerge= [SELECT name
      FROM account
      WHERE name LIKE '%satwa%'
      LIMIT 2];
      
      
     account accmerge1=accmerge[0];
      
      system.debug(accmerge1);
      account accmerge2=accmerge[1];
      
     system.debug(accmerge2);
      
      list<account> accmer3=new list<account>();
      
      system.debug(accmerge2);
      merge accmerge1 accmerge2;
      system.debug(accmerge1);
      system.debug(accmerge2);
  }
    // result classes
    public static void resultclass1(){
    
    // Create the list of sObjects to insert
List<Account> acctList = new List<Account>();
acctList.add(new Account(Name='satwa1'));
acctList.add(new Account(Name='satwa2'));
acctList.add(new Account());

// DML statement
Database.SaveResult[] srList = Database.insert(acctList, true);

// Iterate through each returned result
for (Database.SaveResult sr : srList) {
    system.debug(sr);
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
    }
    else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
        }
        }
    }
}
    
    public static void databasesavepoint_rollback(){
        
        
      account accsave=new account();
        
        savepoint sp1=database.setsavepoint();
      
        List<Account> acc = new List<Account>{new Account(Name='satta1')};
        insert acc; // Don't forget to perform DML to save it
        
        database.rollback(sp1);
        accsave.Name='satwa';
         savepoint sp2=database.setsavepoint(); 
       database.insert(accsave);
       database.rollback(sp2);        
        //List<Account> accs1 = new List<Account>{new Account(Name='satta12')};
        
       //database.insert(accs1);        
    }
    
    
}