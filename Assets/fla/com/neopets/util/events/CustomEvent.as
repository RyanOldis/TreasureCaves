package com.neopets.util.events
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const SEND:String = "send";
       
      
      public var oData:Object;
      
      public function CustomEvent(param1:Object, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this.oData = param1;
      }
   }
}
