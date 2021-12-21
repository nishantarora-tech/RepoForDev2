public class selectedSizeWorkaroundController {

    ApexPages.StandardSetController setCon;

    public selectedSizeWorkaroundController (ApexPages.StandardSetController controller) {
        setCon = controller;
    }

    public integer getMySelectedSize() {
        return setCon.getSelected().size();
    }
    public integer getMyRecordsSize() {
        return setCon.getRecords().size();
    }
}