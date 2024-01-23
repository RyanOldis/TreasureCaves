package com.neopets.projects.np9.system
{
   public class NP9_Tracer
   {
       
      
      private var bDebug:Boolean;
      
      private var objDisplay:Object;
      
      public function NP9_Tracer(param1:Object, param2:Boolean)
      {
         super();
         this.objDisplay = param1;
         this.bDebug = param2;
      }
      
      public function setDebug(param1:Boolean) : void
      {
         this.bDebug = param1;
      }
      
      public function out(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = "**";
         if(this.bDebug || param2)
         {
            if(this.bDebug && !param2)
            {
               _loc3_ += "[DEBUG]";
            }
            _loc3_ += String(this.objDisplay) + ": " + param1;
            trace(_loc3_);
         }
      }
   }
}
