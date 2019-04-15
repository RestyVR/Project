/*
 *Class SystemUtility 
* Class used to capture exception
 */
public class SystemUtility{ 

    List<SystemLog__c> lstoflog = new List<SystemLog__c>();
    /*
    * Method will capture logs
    */
    
    public  void sysLog(String originatingClassName,String logType,String stack){
        if(String.isNotBlank(originatingClassName) && String.isNotBlank(logType) && String.isNotBlank(stack)){
            SystemLog__c sysObj = new SystemLog__c(
                                        Originating_Class_Name__c=originatingClassName , Log_Type__c=logType ,
                                        Stack_Trace__c=stack , Running_User__c=userinfo.getUserId());
           	lstoflog.add(sysObj);
            // insert sysObj;
        }
    }
    public void insertlog(){
        if(lstoflog.size()>0)
            Database.update(lstoflog,false);
    }
        
    
    

}