public class TestDataFactory {
    
    public static account  getAccount(){
        Account accountobj = new Account();
        accountobj.name ='Test Account';
        return accountobj;
    }
    public static List<Contact> getListOfContact(Integer numberOfAccounts){
        List<Contact> lstOfContact = new List<Contact>();
        for(Integer i=0;i<numberOfAccounts;i++){
           
            Contact obj = new Contact();
            obj.LastName  = 'Test user'+ i;
            obj.Email = 'test'+i+'@gmail.com';
            obj.language__c ='DE';
            obj.Survey_Date__c =system.now()-1;
            lstOfContact.add(obj);
        }
        return lstOfContact;
    }

}