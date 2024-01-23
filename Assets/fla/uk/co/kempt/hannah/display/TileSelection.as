package uk.co.kempt.hannah.display
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.tiles.AbstractTile;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class TileSelection extends Sprite
   {
       
      
      private var _start:Point;
      
      private var _tile:AbstractTile;
      
      private var _end:Point;
      
      public function TileSelection(param1:Point, param2:Class = null)
      {
         super();
         this._start = param1;
         this._end = this._start.clone();
         this._tile = new param2() as AbstractTile;
      }
      
      public function die() : void
      {
         graphics.clear();
         this._start = null;
         this._end = null;
         GarbageUtil.kill(this);
      }
      
      public function get left() : int
      {
         return Math.min(this._start.x,this._end.x);
      }
      
      public function update(param1:Point) : void
      {
         this._end = param1.clone();
         if(this._tile)
         {
            if(this._tile.unique)
            {
               this._end = this._start.clone();
            }
            else
            {
               if(this._tile.fillWidth > 1)
               {
                  this._end.x = this._start.x;
               }
               if(this._tile.fillHeight > 1)
               {
                  this._end.y = this._start.y;
               }
            }
         }
         var _loc2_:Number = this.left;
         var _loc3_:Number = this.right;
         var _loc4_:Number = this.top;
         var _loc5_:Number = this.bottom;
         _loc2_ *= Engine.TILE_SIZE;
         _loc3_ *= Engine.TILE_SIZE;
         _loc4_ *= Engine.TILE_SIZE;
         _loc5_ *= Engine.TILE_SIZE;
         _loc3_ += Engine.TILE_SIZE;
         _loc5_ += Engine.TILE_SIZE;
         graphics.clear();
         graphics.beginFill(255,0.3);
         graphics.drawRect(0,0,_loc3_ - _loc2_,_loc5_ - _loc4_);
         x = _loc2_;
         y = _loc4_;
      }
      
      public function get bottom() : int
      {
         return Math.max(this._start.y,this._end.y);
      }
      
      public function get top() : int
      {
         return Math.min(this._start.y,this._end.y);
      }
      
      public function getSelection() : Rectangle
      {
         return new Rectangle(this.left,this.top,this.right - this.left + 1,this.bottom - this.top + 1);
      }
      
      public function get right() : int
      {
         return Math.max(this._start.x,this._end.x);
      }
   }
}
