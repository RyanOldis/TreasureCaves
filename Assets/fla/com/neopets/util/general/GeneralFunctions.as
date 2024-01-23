package com.neopets.util.general
{
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   
   public class GeneralFunctions
   {
       
      
      public function GeneralFunctions()
      {
         super();
      }
      
      public static function convertBoolean(param1:Object) : Object
      {
         var _loc3_:String = null;
         var _loc2_:Object = param1;
         if(param1 is XML || param1 is XMLList)
         {
            param1 = param1.toString();
         }
         switch(typeof param1)
         {
            case "number":
               if(param1 == 0)
               {
                  _loc2_ = false;
               }
               else if(param1 == 1)
               {
                  _loc2_ = true;
               }
               break;
            case "string":
               if(Number(param1) == 0)
               {
                  _loc2_ = false;
               }
               else if(Number(param1) == 1)
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc3_ = String(param1.toLowerCase());
                  if(_loc3_ == "false")
                  {
                     _loc2_ = false;
                  }
                  else if(_loc3_ == "true")
                  {
                     _loc2_ = true;
                  }
               }
         }
         return _loc2_;
      }
      
      public static function setParamatersList(param1:Object, param2:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         for each(_loc3_ in param2.*)
         {
            if(param1.hasOwnProperty(_loc3_.name()))
            {
               _loc4_ = _loc3_.toString();
               _loc4_ = isNaN(_loc4_) ? _loc4_ : Number(_loc4_);
               param1[_loc3_.name()] = convertBoolean(_loc4_);
            }
         }
      }
      
      public static function getInstanceOf(param1:String, param2:ApplicationDomain = null) : Object
      {
         var _loc3_:Object = null;
         if(param1 == null || param1.length <= 0)
         {
            return null;
         }
         if(param2 == null)
         {
            param2 = ApplicationDomain.currentDomain;
         }
         if(param2.hasDefinition(param1))
         {
            _loc3_ = param2.getDefinition(param1);
            return new _loc3_();
         }
         return null;
      }
      
      public static function setParamater(param1:Object, param2:Object) : void
      {
         var _loc3_:* = undefined;
         if(param1.hasOwnProperty(param2.name()))
         {
            _loc3_ = param2.toString();
            _loc3_ = isNaN(_loc3_) ? _loc3_ : Number(_loc3_);
            param1[param2.name()] = convertBoolean(param2);
         }
      }
      
      public static function convertToArray(param1:String, param2:Object) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array;
         var _loc5_:int = int((_loc4_ = param1.split(",")).length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(param2.hasOwnProperty(_loc4_[_loc6_]))
            {
               _loc3_.push(param2[_loc4_[_loc6_]]);
            }
            else
            {
               _loc3_.push(_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function cloneObject(param1:Object, param2:ApplicationDomain = null) : Object
      {
         var _loc3_:String = null;
         if(param1 != null)
         {
            _loc3_ = getQualifiedClassName(param1);
            return getInstanceOf(_loc3_,param2);
         }
         return null;
      }
   }
}
