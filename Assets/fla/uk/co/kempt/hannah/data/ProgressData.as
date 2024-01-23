package uk.co.kempt.hannah.data
{
   import flash.net.SharedObject;
   
   public class ProgressData
   {
      
      private static const SHARED_OBJECT_NAME:String = "hannah_moon";
      
      private static const DEBUG:Boolean = false;
       
      
      private var _sharedObject:SharedObject;
      
      private var _level:int;
      
      public function ProgressData()
      {
         super();
         this._level = 1;
         this.retrieve();
         this.getAndSetProp("level");
      }
      
      private function debug(... rest) : void
      {
         if(DEBUG)
         {
            trace(rest);
         }
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
         this.setProp("level",this._level);
      }
      
      private function getProp(param1:String) : Object
      {
         if(this._sharedObject)
         {
            if(this._sharedObject.data.hasOwnProperty(param1))
            {
               return this._sharedObject.data[param1];
            }
            this.debug("ProgressData: property " + param1 + " does not exist");
         }
         else
         {
            this.debug("ProgressData: no shared object");
         }
         return null;
      }
      
      private function getAndSetProp(param1:String) : void
      {
         var tValue:Object;
         var pName:String = param1;
         this.debug("getAndSetProp");
         tValue = this.getProp(pName);
         this.debug("value: " + tValue);
         if(tValue)
         {
            try
            {
               this[pName] = tValue;
               this.debug("assigned: " + this[pName]);
            }
            catch(e:Error)
            {
               debug("ProgressData: " + e.message);
            }
         }
      }
      
      private function setProp(param1:String, param2:Object) : void
      {
         var pName:String = param1;
         var pValue:Object = param2;
         this.debug("ProgressData: setProp");
         if(this._sharedObject)
         {
            this._sharedObject.data[pName] = pValue;
            try
            {
               this._sharedObject.flush();
            }
            catch(e:Error)
            {
               debug("ProgressData: problem flushing SharedObject");
            }
         }
      }
      
      private function retrieve() : void
      {
         try
         {
            this._sharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         }
         catch(e:Error)
         {
            debug("ProgressData: problem creating SharedObject");
         }
      }
   }
}
