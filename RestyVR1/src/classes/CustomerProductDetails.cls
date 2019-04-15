/************************************************************
Name: CustomerProductDetails
Type: Apex Class  
Purpose: class will return product name,services and cost.
Author :vinod.rajput214@gmail.com                           
***********************************************************/
public with sharing class CustomerProductDetails {

    @AuraEnabled // return list of pricebook name based on product selection
    public static List <ProductInfoWrapper> getProductInfo(String caseId) {
        List<ProductInfoWrapper> lstofProductInfo = new List<ProductInfoWrapper>();
        
        Case caseObj = [SELECT Contactid,Contact.Home_Country__c,Contact.Product__c FROM CASE 
         												   WHERE id =:caseId
        												   LIMIT 1];
        if(String.isNotBlank(caseObj.Contact.Product__c ) && String.isNotBlank(caseObj.Contact.Home_Country__c)){
        
            List<PricebookEntry> lstofPriceBookEntry  = [SELECT ID,Product2.Name,Product2.Percent__c,Product2id,Pricebook2.name,unitprice
                                                     	 FROM PricebookEntry
                                                         WHERE Product2.Country__c =:caseObj.Contact.Home_Country__c AND Product2id =:caseObj.Contact.Product__c AND Pricebook2.isActive =true AND Product2.isActive=true
                                                    	];
            
            for(PricebookEntry pricebookEntryobj : lstofPriceBookEntry){
               
                String cost = (null!= pricebookEntryobj.Product2.Percent__c) ? string.valueOf(pricebookEntryobj.Product2.Percent__c) : (pricebookEntryobj.unitprice ==0.0) ? 'Free' : string.valueOf(pricebookEntryobj.unitprice);
                system.debug('cost'+cost);
                system.debug('Cost'+pricebookEntryobj.unitprice);
                lstofProductInfo.add(new ProductInfoWrapper(pricebookEntryobj.Product2.Name,pricebookEntryobj.Pricebook2.name,cost,caseObj.Contact.Home_Country__c,true));
                
                
            }
        }
        else{
            lstofProductInfo.add(new ProductInfoWrapper('','','','',false));
        }
        
        return lstofProductInfo;
        
	        
    }
    
    /* wrapper class */  
    public class ProductInfoWrapper {
        @AuraEnabled public String productName {get;set;}
        @AuraEnabled public String TypeOfProduct {get;set;}
        @AuraEnabled public String Cost{get;set;}
        @AuraEnabled public String Country{get;set;}
 		@AuraEnabled public boolean isProductSelected {get;set;}       
        public ProductInfoWrapper(String productName,String TypeOfProduct,String Cost,String Country,boolean isProductSelected){
           	this.productName		= productName;
            this.TypeOfProduct		= TypeOfProduct;
            this.Cost				= Cost;
            this.Country			= Country;
            this.isProductSelected  = isProductSelected;
            
        }
    }
    
}