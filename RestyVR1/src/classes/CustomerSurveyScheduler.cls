/************************************************************
Name: CustomerSurveyScheduler
Type: Apex Class  
Purpose: Schedule batch job
Author :vinod.rajput214@gmail.com                           
***********************************************************/
global class CustomerSurveyScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Batch_SendSurveyToCustomer sendSurveyObj = new Batch_SendSurveyToCustomer();
        Database.executeBatch(sendSurveyObj,200);
    }
}