public class blobToStringController {
    public blobToStringController(){
        StaticResource sr = [Select body, name from StaticResource where Name = 'blob'];
        String str;
        str = (sr.body).toString();
        system.debug('-------'+sr);
        system.debug('---str----'+str);
    }    
}