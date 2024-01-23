package uk.co.kempt.hannah.display
{
   import com.asliceofcrazypie.geom2d.Grid;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.data.tiles.AbstractTile;
   import uk.co.kempt.hannah.utils.ExportUtil;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class LevelPreview extends Sprite
   {
      
      private static const MAX_HEIGHT:Number = 301 - 20;
      
      private static const MAX_WIDTH:Number = 544 - 20;
       
      
      private var _bitmap:Bitmap;
      
      public function LevelPreview(param1:String)
      {
         var _loc5_:AbstractTile = null;
         var _loc12_:int = 0;
         super();
         mouseEnabled = mouseChildren = false;
         var _loc2_:LevelData = ExportUtil.importByString2(param1);
         var _loc3_:Grid = _loc2_.grid;
         var _loc4_:BitmapData;
         var _loc6_:int = (_loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,16711680)).height - 1;
         var _loc7_:int = _loc4_.width - 1;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         while(_loc10_ < _loc3_.width)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc3_.height)
            {
               if(!(_loc5_ = _loc3_.getSquareAt(_loc10_,_loc12_) as AbstractTile).solid)
               {
                  _loc4_.setPixel32(_loc10_,_loc12_,4278190080);
                  _loc6_ = Math.min(_loc6_,_loc12_);
                  _loc7_ = Math.min(_loc7_,_loc10_);
                  _loc8_ = Math.max(_loc8_,_loc12_);
                  _loc9_ = Math.max(_loc9_,_loc10_);
               }
               _loc12_++;
            }
            _loc10_++;
         }
         var _loc11_:BitmapData;
         (_loc11_ = new BitmapData(_loc9_ - _loc7_,_loc8_ - _loc6_,true,65280)).copyPixels(_loc4_,new Rectangle(_loc7_,_loc6_,_loc11_.width,_loc11_.height),new Point());
         _loc4_.dispose();
         this._bitmap = new Bitmap(_loc11_,PixelSnapping.ALWAYS);
         this._bitmap.scaleX = this._bitmap.scaleY = 5;
         if(this._bitmap.width > MAX_WIDTH)
         {
            this._bitmap.width = MAX_WIDTH;
            this._bitmap.scaleY = this._bitmap.scaleX;
         }
         if(this._bitmap.height > MAX_HEIGHT)
         {
            this._bitmap.height = MAX_HEIGHT;
            this._bitmap.scaleX = this._bitmap.scaleY;
         }
         addChild(this._bitmap);
         this._bitmap.filters = [new GlowFilter(16777215,0.7,3.2,3.2,10,1,false,true),new GlowFilter(13434879,1,8,8,2.6,2)];
      }
      
      public function die() : void
      {
         try
         {
            this._bitmap.bitmapData.dispose();
            this._bitmap.bitmapData = null;
            this._bitmap = null;
         }
         catch(e:Error)
         {
         }
         GarbageUtil.kill(this);
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
      }
   }
}
