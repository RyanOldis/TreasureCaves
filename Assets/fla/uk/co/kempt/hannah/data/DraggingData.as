package uk.co.kempt.hannah.data
{
   import flash.geom.Point;
   
   public class DraggingData
   {
       
      
      private var _objectStart:Point;
      
      private var _mouseStart:Point;
      
      public function DraggingData(param1:Point, param2:Point)
      {
         super();
         this._objectStart = param1;
         this._mouseStart = param2;
      }
      
      public function get objectStart() : Point
      {
         return this._objectStart;
      }
      
      public function get mouseStart() : Point
      {
         return this._mouseStart;
      }
   }
}
