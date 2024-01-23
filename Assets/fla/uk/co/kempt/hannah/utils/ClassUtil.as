package uk.co.kempt.hannah.utils
{
   import flash.display.DisplayObject;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ClassUtil
   {
       
      
      public function ClassUtil()
      {
         super();
      }
      
      public static function getClass(param1:Object) : Class
      {
         var pObject:Object = param1;
         try
         {
            return getDefinitionByName(getQualifiedClassName(pObject)) as Class;
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public static function duplicateDisplayObject(param1:DisplayObject) : DisplayObject
      {
         var tClass:Class = null;
         var pDisplayObject:DisplayObject = param1;
         try
         {
            tClass = getClass(pDisplayObject);
            return new tClass() as DisplayObject;
         }
         catch(e:Error)
         {
            return null;
         }
      }
   }
}
