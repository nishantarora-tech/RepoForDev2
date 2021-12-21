public class ComponentResponse{
    //public Id componentId;
    public list<Component> componentData;
    public class Component{
    public Id componentId;        
    public ReportResult reportResult;
    }
    public class ReportResult {        
        public ReportMetadata reportMetadata;                
        public ReportResult() {
        }
    }
    public class ReportMetadata {
        public Id id;
        public string name;       
        public ReportMetadata () {
        }
    } 
              
}