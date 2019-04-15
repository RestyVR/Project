<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Survey_Email</fullName>
        <description>Survey Email will send to customer based on contact language</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Survey_Template_DE_EN/Survey_Email_Template</template>
    </alerts>
    <rules>
        <fullName>Send Customer Survey email</fullName>
        <actions>
            <name>Survey_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sending Survey email to customer based on contact language</description>
        <formula>AND( 
	ISCHANGED( Survey_Date__c ), 
	NOT(
		ISNULL(
				PRIORVALUE(Survey_Date__c)
			)
	)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
