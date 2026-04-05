@RestResource(urlMapping='/CreateRecord2')
Global class API_Inbound {

 @HTTPGet
    global static string Method(){
        
        system.debug('done');
        
        return 'success';
        
    }
    
    @HttpPost
    global static string methodpostman(){
        
        restrequest req=restcontext.request;
        system.debug(req);
        string sr1= req.requestbody.tostring();
        system.debug(sr1);
        //list<object> srlist= (list<object>)JSON.deserializeUntyped(sr);
         DataWrapperClass DS=(DataWrapperClass)JSON.deserialize(sr1, DataWrapperClass.class);
        //system.debug(DS);
        system.debug('data - '+DS);
        
        return 'success';
    }
    
    
    
    //collecting data from external website and refining it and doing DML operation to store the data in form of a record back in salesforce object.
    //@HttpPost
    global static list<string> MethodPost(){
        //-->handle req
        Restrequest req= restcontext.request ;
        system.debug(req);
        string sr = req.requestbody.tostring();  // blob to string converion of requestbody
        system.debug(sr);
        
        
        
        //Map<String, Object> stMap=(Map<String, Object>)JSON.deserializeUntyped(sr);
        /*system.debug(stMap);
        system.debug('name--> '+stMap.get('name'));
        //-->process req
        account ac= new account();
        
        ac.Name =(string)stMap.get('name');
        ac.NumberOfEmployees=(integer)stMap.get('empnumber');
        
        database.insert(ac,false);*/
        list<object> srlist= (list<object>)JSON.deserializeUntyped(sr);
        
        
        list<account> ac1=new list<account>();
        list<string> studname=new list<string>();
        
        for(object sList:srlist){
            system.debug(sList);
            
            Map<string , object> stmap=(Map<string , object>)sList;
            
            account ac2=new account();
            ac2.name=(string)stmap.get('name');
            ac2.NumberOfEmployees=(integer)stmap.get('empnumber');
            
            ac1.add(ac2);
            
            studname.add(ac2.name);
            
        }
        
        database.insert(ac1,false);
        //database.insert()
        
        //-->return req
        return studname ;
    }
    
}