/************************************************************
Name: Batch_SendSurveyToCustomerTestClass
Type: Test Class  
Purpose: Verify unit test results
Author :vinod.rajput214@gmail.com                           
***********************************************************/
@isTest
public class Batch_SendSurveyToCustomerTestClass {
    
    @isTest
    public static void verifyCustomerSurveydateTONull(){
        Account accountObj	=TestDataFactory.getAccount();
        insert accountObj;
        List<Contact> lstOfContact = TestDataFactory.getListOfContact(200);
        for(Contact obj :lstOfContact){
            obj.accountid =accountObj.id;
        }
        insert lstOfContact;
        Test.startTest();
            Batch_SendSurveyToCustomer obj = new Batch_SendSurveyToCustomer();
            Database.executeBatch(Obj);
        Test.stopTest();
         for(Contact Conobj : [Select id,Survey_Date__c,accountid from contact where id in :lstOfContact]){
            system.debug('Conobj'+Conobj.Survey_Date__c);
             system.assertEquals(null,String.valueOf(Conobj.Survey_Date__c));
            system.debug('Conobj'+Conobj.id);
        }
        
    }
	@isTest
    public static void verifyCustomerSurveyScheduler(){
        Account accountObj	=TestDataFactory.getAccount();
        insert accountObj;
        
        List<Contact> lstOfContact = TestDataFactory.getListOfContact(200);
        for(Contact obj :lstOfContact){
            obj.accountid =accountObj.id;
        }
        insert lstOfContact;
        
        Test.startTest();
        
         CustomerSurveyScheduler obj = new CustomerSurveyScheduler();      
         String corn = '0 0 0 14 4 ? 2022';
         String jobId = system.schedule('Survey request', corn, obj);
         CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
         System.assertEquals(0, ct.TimesTriggered);
		 // Verify the job has not run 
         System.assertEquals(0, ct.TimesTriggered); 
          // Verify the next time the job will run 
         System.assertEquals('2022-04-14 00:00:00', String.valueOf(ct.NextFireTime));  
         Test.stopTest();
        
    }
    
    
}