public with sharing class ContactController2 {
	@AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts =
        [SELECT Id, Name, MailingStreet, Phone, Email, LeadSource FROM Contact];
        //Add isAccessible() check
        return contacts;
    }
}