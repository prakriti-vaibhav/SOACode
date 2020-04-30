public class LightningHelperController {
    @AuraEnabled
    public static list<Account> recentAccountList(){
        return [select Id, name from Account order by createddate desc limit 10];             
    }
}