public class ApexClassSearchSLDSWithAutoSuggestion {

    public String searchTerm {get; set;}
    public String selectedClass {get; set;}    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    public static List<ApexClass> searchClass(String searchTerm) {
        System.debug('Movie Name is: '+searchTerm );
        List<ApexClass> apexClassList = Database.query('Select Id, Name from ApexClass where name like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'');
        return apexClassList;
    }
}