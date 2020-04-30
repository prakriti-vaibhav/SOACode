trigger UpdateContactCount on Contact (after insert, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();
    
    if(Trigger.isAfter){
        IF(Trigger.IsInsert || Trigger.IsUndelete){
            for(contact con : trigger.new){
                if(con.AccountId != null)
                    accountIds.add(con.AccountId);
            }
        }
    }
    if(Trigger.isDelete){
        for(contact con : trigger.old){
            if(con.AccountId != null)
                accountIds.add(con.AccountId);
        }
    }
    List<Account> accountsToUpdate = new List<Account>();
    if(accountIds != null && accountIds.size() > 0){
        List<Account> lstAccount = [select id,Number_of_Contacts__c,(select id from contacts) from Account where id IN: accountIds];
        for(Account acc : lstAccount){
            accountsToUpdate.add(new Account(Id= acc.Id, Number_of_Contacts__c = acc.contacts.size()));
        }
    }
    
    if(accountsToUpdate != null && accountsToUpdate.size() > 0){
        try{
            update accountsToUpdate;
        }catch(System.Exception e){system.debug(e);}
    }
    
}