trigger HastaTrigger on Hasta__c (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
SWITCH on Trigger.operationType {
       WHEN BEFORE_INSERT {}
       
       WHEN BEFORE_UPDATE { }
       
            
      
       WHEN BEFORE_DELETE { }
       WHEN AFTER_UPDATE  { 
           List<ID> HastId = new List<ID>();
             List<ID> PaylaslanKisi = new List<ID>();
           for(Hasta__c forDelet: trigger.old){
               
          HastId.add(forDelet.Id);
          PaylaslanKisi.add(forDelet.Hem_ire__c);     
           }
           List<Hasta__Share> deleteQuery = [SELECT Id, ParentId FROM Hasta__Share WHERE ParentId IN: HastId AND
                                            UserOrGroupId IN: PaylaslanKisi];
           database.delete(deleteQuery);
            for(Hasta__c hast:trigger.new){
        HastaHandler.SharingWithParamtr(trigger.new, hast.doktor__c );
        HastaHandler.SharingWithParamtr(trigger.new, hast.Hem_ire__c );   
        }
       
       
       }
      
        
      
        WHEN AFTER_DELETE  {  }
        

        WHEN AFTER_UNDELETE { } 
    WHEN AFTER_INSERT  {
        //1.Yol
        /*List< Hasta__Share> ListSharing = new  List< Hasta__Share>(); 
        for(Hasta__c hast:trigger.new){
         Hasta__Share newShare = new Hasta__Share();
         newShare.ParentId =hast.id;
         newShare.UserOrGroupId = hast.Hem_ire__c;
         newShare.AccessLevel = 'Edit';
         newShare.RowCause = 'Manual'; 
         ListSharing.add(newShare);   
        } 
        insert ListSharing;*/
        
        //HastaHandler.createdDoctor(trigger.new);
        
       //2.yol
        /*for(Hasta__c hast:trigger.new){
        HastaHandler.SharingWithParamtr(trigger.new, hast.doktor__c );
        HastaHandler.SharingWithParamtr(trigger.new, hast.Hem_ire__c );   
        }*/
    
    //3.Yol
    /*HastaHandler.shareWith(trigger.new, 'Hemsire');
     HastaHandler.shareWith(trigger.new, 'Doctor');*/
        
   //4.yol
   List<Hasta__Share> ShareList = new List<Hasta__Share>();
        for(Hasta__c hasta:trigger.new){
 Hasta__Share record1 = HastaHandler.paylasmaRecordOlustur(hasta.Id, hasta.Hem_ire__c);
  Hasta__Share record2 = HastaHandler.paylasmaRecordOlustur(hasta.Id, hasta.doktor__c);
     ShareList.add(record1); 
     ShareList.add(record2);       
        }
    database.insert(ShareList);    
}
}   
}