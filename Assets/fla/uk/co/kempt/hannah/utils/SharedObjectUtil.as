package uk.co.kempt.hannah.utils
{
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   
   public class SharedObjectUtil
   {
      
      private static var SHARED_OBJECTS:Dictionary;
       
      
      public function SharedObjectUtil()
      {
         super();
      }
      
      public static function getSharedObject(param1:String) : SharedObject
      {
         return SharedObject.getLocal(param1);
      }
      
      public static function retrieveFromSharedObject(param1:String, param2:String) : *
      {
         var _loc3_:SharedObject = getSharedObject(param1);
         return _loc3_.data[param2];
      }
      
      public static function writeToSharedObject(param1:String, param2:String, param3:*) : void
      {
         var pName:String = param1;
         var pPropName:String = param2;
         var pData:* = param3;
         var tSharedObject:SharedObject = getSharedObject(pName);
         tSharedObject.data[pPropName] = pData;
         try
         {
            tSharedObject.flush();
         }
         catch(e:Error)
         {
            trace(e.message);
         }
      }
      
      private static function get sharedObjects() : Dictionary
      {
         return SHARED_OBJECTS = SHARED_OBJECTS || new Dictionary();
      }
   }
}
