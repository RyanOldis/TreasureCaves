package uk.co.kempt.hannah.world
{
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   
   public class SolidBlock extends WorldObject
   {
       
      
      private var _blockHeight:Number;
      
      private var _blockWidth:Number;
      
      public function SolidBlock()
      {
         super();
         this._blockWidth = NaN;
         this._blockHeight = NaN;
      }
      
      override protected function createBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x,y,isNaN(this._blockWidth) ? Engine.TILE_SIZE : this._blockWidth,isNaN(this._blockHeight) ? Engine.TILE_SIZE : this._blockHeight));
      }
      
      public function set blockWidth(param1:Number) : void
      {
         this._blockWidth = param1;
         onPositionChanged();
      }
      
      override public function get fixed() : Boolean
      {
         return true;
      }
      
      public function get blockWidth() : Number
      {
         return this._blockWidth;
      }
      
      public function get blockHeight() : Number
      {
         return this._blockHeight;
      }
      
      public function set blockHeight(param1:Number) : void
      {
         this._blockHeight = param1;
         onPositionChanged();
      }
   }
}
