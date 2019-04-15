/************************************************************
Name: Batch_SendSurveyToCustomer
Type: Batch Class  
Test class :Batch_SendSurveyToCustomerTestClass
Purpose: Batch job will pick records and mark survey request to null and email will trigger from workflow.
Note : if any excption is occuring then we are storing exception in Systemlog object.
Author :vinod.rajput214@gmail.com                           
***********************************************************/
global class Batch_SendSurveyToCustomer implements Database.Batchable<sObject> {
    
	String QUERY_NAME ='Customer_Survey_Query';
    String CustomerSurveyQuery;
    global Batch_SendSurveyToCustomer(){
        // SOQL Query to fetch records
        CustomerSurveyQuery = [SELECT DeveloperName,SOQL_Query__c FROM SOQL_Queries__mdt 
                               									  WHERE DeveloperName=:QUERY_NAME
                               									  LIMIT 1	
                              ].SOQL_Query__c;
        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){   
        return Database.getQueryLocator(CustomerSurveyQuery);
    }
    global void execute(Database.BatchableContext bc, List<Contact> lstOfCotacts){
       
        String errormessage; // maintain error during updation of record
        List<Contact> lstOfContactNeedToUpdate = new List<Contact>();
		for(Contact contactObj :lstOfCotacts){
			contact contactobject 			= new contact(id =contactObj.id);
			contactobject.Survey_Date__c	= null;
			lstOfContactNeedToUpdate.add(contactobject);
		}
		if(lstOfContactNeedToUpdate.size()>0){
			
            List<Database.SaveResult> saveResultList = database.update(lstOfContactNeedToUpdate,false); // update list of contacts
            SystemUtility obj = new SystemUtility();
			for(integer i =0; i<lstOfContactNeedToUpdate.size();i++){
            	
            	if(!saveResultList[i].isSuccess()){
                    errormessage += 'Contact id : '+' '+saveResultList[i].getid() + '\n'+'Error: "';        
                    for(Database.Error err: saveResultList[i].getErrors()){  
                         errormessage += err.getmessage()+'"\n\n';
                    } 
                    obj.sysLog('Batch_SendSurveyToCustomer','Exception',errormessage);
            	}
            }
            obj.insertlog();// insert all failure contacts*/
		}
    }
    global void finish(Database.BatchableContext BC){
		
	}
   
}