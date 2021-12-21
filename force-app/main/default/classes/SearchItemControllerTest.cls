@isTest
public class SearchItemControllerTest{
    public static testMethod void  searchName(){
        String[] selectedObj = new String[]{'Account','Contact'};
        //Creation of SearchItemController  Object
        SearchItemController searchItemObject= new SearchItemController();        
        searchItemObject.setSelectedObj(selectedObj);
        searchItemObject.getSelectedObj();
        searchItemObject.getItems();
        searchItemObject.gotoHomePage();
        searchItemObject.strSearchText='Search...';
        searchItemObject.searchResultsMethod();
        searchItemObject.strSearchText='a';
        searchItemObject.searchResultsMethod();
        Account a = new Account(Name='test1');
        insert a;
        sObject s = [Select Id FROM Account where Name = 'test1']; 
        List<sObject> sObjectList= new List<sObject>();
        sObjectList.add(s);
        //Creation of searchResultRow(wrapper class) Object                             
        SearchItemController.searchResultRow searchResultRowObject= new SearchItemController.searchResultRow(sObjectList,'Account');                  
    }   
}