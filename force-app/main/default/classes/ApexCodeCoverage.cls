public class ApexCodeCoverage{
    List<ApexClass> apexClsObj {get;set;}
    public ApexCodeCoverage(){
        apexClsObj = [select name from ApexClass];
    }
}