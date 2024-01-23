package com.neopets.util.flashvars
{
   import flash.display.LoaderInfo;
   
   public class FlashVarsFinder
   {
       
      
      public function FlashVarsFinder()
      {
         super();
      }
      
      public static function findVar(param1:Object, param2:String) : String
      {
         var paramObj:Object = null;
         var pRoot:Object = param1;
         var pFlashVars:String = param2;
         var flashVarsValue:String = null;
         try
         {
            paramObj = LoaderInfo(pRoot.loaderInfo).parameters;
            flashVarsValue = String(paramObj[pFlashVars]);
            trace("The flash var is: " + flashVarsValue);
         }
         catch(error:Error)
         {
            trace(error.toString());
         }
         return flashVarsValue;
      }
   }
}
