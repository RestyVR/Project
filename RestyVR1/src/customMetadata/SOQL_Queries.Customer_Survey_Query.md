<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Customer Survey Query</label>
    <protected>false</protected>
    <values>
        <field>SOQL_Query__c</field>
        <value xsi:type="xsd:string">SELECT Id,language__c FROM Contact WHERE Survey_Date__c &lt;= Today AND language__c != &apos;Null&apos; AND Email != &apos;Null&apos;</value>
    </values>
</CustomMetadata>
