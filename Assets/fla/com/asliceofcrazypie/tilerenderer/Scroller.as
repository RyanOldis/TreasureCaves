package com.asliceofcrazypie.tilerenderer
{
   import com.asliceofcrazypie.geom2d.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Scroller extends Bitmap
   {
       
      
      protected var m_sprites:Dictionary;
      
      protected var m_tileHeight:int;
      
      protected var m_baseCol:uint;
      
      protected var m_lastCY:Number;
      
      protected var m_lastCX:Number;
      
      protected var m_tiles:Vector.<com.asliceofcrazypie.tilerenderer.ITile>;
      
      protected var m_height:Number;
      
      protected var m_point:Point;
      
      protected var m_lastViewpoint:Point;
      
      protected var m_bmp:BitmapData;
      
      protected var m_matrix:Matrix;
      
      protected var m_grid:Grid;
      
      protected var m_aTileHeight:int;
      
      protected var m_zoom:Number = 1;
      
      protected var m_aTileWidth:int;
      
      protected var m_width:Number;
      
      protected var m_tileWidth:int;
      
      public function Scroller(param1:int, param2:int, param3:Grid, param4:int, param5:int, param6:uint = 0, param7:String = "auto", param8:Boolean = false)
      {
         this.m_matrix = new Matrix();
         this.m_point = new Point();
         super(null,param7,param8);
         this.m_width = param1;
         this.m_height = param2;
         this.m_tileWidth = param4;
         this.m_tileHeight = param5;
         this.m_grid = param3;
         this.m_baseCol = param6;
         this.m_sprites = new Dictionary();
         this.updateAdjustedTileSizes();
      }
      
      public function die() : void
      {
         var _loc1_:Object = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         for(_loc1_ in this.m_sprites)
         {
            BitmapData(this.m_sprites[_loc1_]).dispose();
            delete this.m_sprites[_loc1_];
         }
         this.grid = null;
         this.m_lastViewpoint = null;
         if(this.m_bmp)
         {
            this.m_bmp.dispose();
            this.m_bmp = null;
         }
      }
      
      public function get bmp() : BitmapData
      {
         return this.m_bmp;
      }
      
      public function get adjustedTileHeight() : int
      {
         return this.m_aTileHeight;
      }
      
      override public function set width(param1:Number) : void
      {
         this.m_width = param1;
         this.reset();
      }
      
      public function set grid(param1:Grid) : void
      {
         this.m_grid = param1;
         this.reset(true);
      }
      
      public function get tiles() : Vector.<com.asliceofcrazypie.tilerenderer.ITile>
      {
         return this.m_tiles;
      }
      
      public function render(param1:Point, param2:Number = 0.5, param3:Number = 0.5) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc12_:* = undefined;
         var _loc13_:BitmapData = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc4_:Number = param1.x - this.m_width * param2;
         var _loc5_:Number = param1.y - this.m_height * param3;
         this.m_bmp.fillRect(this.m_bmp.rect,this.m_baseCol);
         if(_loc4_ < 0)
         {
            _loc6_ = -_loc4_;
         }
         else
         {
            _loc6_ = -_loc4_ % this.m_aTileWidth;
         }
         if(_loc5_ < 0)
         {
            _loc7_ = -_loc5_;
         }
         else
         {
            _loc7_ = -_loc5_ % this.m_aTileHeight;
         }
         var _loc8_:Number = Math.floor(_loc4_ / this.m_aTileWidth);
         var _loc9_:Number = Math.floor(_loc5_ / this.m_aTileHeight);
         var _loc10_:Number = Math.ceil((_loc4_ + this.width) / this.m_aTileWidth);
         var _loc11_:Number = Math.ceil((_loc5_ + this.height) / this.m_aTileHeight);
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         else
         {
            _loc10_ -= _loc8_;
         }
         if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         else
         {
            _loc11_ -= _loc9_;
         }
         _loc10_ = _loc10_ + _loc8_ > this.grid.width ? this.grid.width - _loc8_ : _loc10_;
         _loc11_ = _loc11_ + _loc9_ > this.grid.height ? this.grid.height - _loc9_ : _loc11_;
         this.m_tiles = Vector.<com.asliceofcrazypie.tilerenderer.ITile>(this.grid.getSlice(_loc8_,_loc9_,_loc10_,_loc11_));
         var _loc16_:int = int(this.m_tiles.length - 1);
         while(_loc16_ > -1)
         {
            _loc12_ = this.m_tiles[_loc16_].getTileDisplayObj(this.m_aTileWidth,this.m_tileHeight);
            if(this.m_sprites[_loc12_] === undefined)
            {
               this.createSprite(_loc12_);
            }
            _loc13_ = BitmapData(this.m_sprites[_loc12_]);
            _loc14_ = _loc16_ % _loc10_;
            _loc15_ = int(Math.floor(_loc16_ / _loc10_));
            this.m_point.x = _loc14_ * this.m_aTileWidth + _loc6_;
            this.m_point.y = _loc15_ * this.m_aTileHeight + _loc7_;
            this.m_bmp.copyPixels(_loc13_,_loc13_.rect,this.m_point,null,null,false);
            _loc16_--;
         }
         this.m_lastViewpoint = param1;
         this.m_lastCX = param2;
         this.m_lastCY = param3;
      }
      
      public function set zoom(param1:Number) : void
      {
         var _loc2_:int = this.m_zoom;
         this.m_zoom = param1;
         this.updateAdjustedTileSizes(this.m_tileWidth,this.m_tileHeight,_loc2_);
      }
      
      override public function get height() : Number
      {
         return this.m_height;
      }
      
      public function getTileCoordsAt(param1:int, param2:int) : Point
      {
         var _loc3_:Point = new Point();
         _loc3_.x = Math.floor((param1 + this.m_lastViewpoint.x - this.m_lastCX * this.m_width) / this.m_aTileWidth);
         _loc3_.y = Math.floor((param2 + this.m_lastViewpoint.y - this.m_lastCY * this.m_height) / this.m_aTileHeight);
         return _loc3_;
      }
      
      public function get tileWidth() : int
      {
         return this.m_tileWidth;
      }
      
      override public function get width() : Number
      {
         return this.m_width;
      }
      
      public function get grid() : Grid
      {
         return this.m_grid;
      }
      
      override public function set height(param1:Number) : void
      {
         this.m_height = param1;
         this.reset();
      }
      
      protected function reset(param1:Boolean = false) : void
      {
         var _loc2_:Object = null;
         if(param1)
         {
            for(_loc2_ in this.m_sprites)
            {
               BitmapData(this.m_sprites[_loc2_]).dispose();
               delete this.m_sprites[_loc2_];
            }
         }
         if(this.m_bmp)
         {
            this.m_bmp.dispose();
            this.m_bmp = null;
         }
         this.m_bmp = new BitmapData(this.m_width,this.m_height,true,this.m_baseCol);
         bitmapData = this.m_bmp;
         if(this.m_lastViewpoint)
         {
            this.render(this.m_lastViewpoint,this.m_lastCX,this.m_lastCY);
         }
      }
      
      public function get zoom() : Number
      {
         return this.m_zoom;
      }
      
      public function set baseCol(param1:uint) : void
      {
         this.m_baseCol = param1;
         this.render(this.m_lastViewpoint,this.m_lastCX,this.m_lastCY);
      }
      
      protected function createSprite(param1:*) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 is Class)
         {
            _loc2_ = DisplayObject(new (param1 as Class)());
         }
         else if(param1 is DisplayObject)
         {
            _loc2_ = DisplayObject(param1);
         }
         var _loc3_:BitmapData = new BitmapData(this.m_aTileWidth,this.m_aTileHeight,true,0);
         var _loc4_:Rectangle = _loc2_.getBounds(_loc2_);
         this.m_matrix.identity();
         this.m_matrix.translate(-_loc4_.x,-_loc4_.y);
         this.m_matrix.scale(this.m_aTileWidth / _loc4_.width,this.m_aTileHeight / _loc4_.height);
         _loc3_.draw(_loc2_,this.m_matrix,null,null,null,true);
         this.m_sprites[param1] = _loc3_;
      }
      
      public function getVisibleArea(param1:Point, param2:Number = 0.5, param3:Number = 0.5) : Rectangle
      {
         var _loc4_:Number = param1.x - this.m_width * param2;
         var _loc5_:Number = param1.y - this.m_height * param3;
         var _loc6_:Number = Math.floor(_loc4_ / this.m_aTileWidth);
         var _loc7_:Number = Math.floor(_loc5_ / this.m_aTileHeight);
         var _loc8_:Number = Math.ceil((_loc4_ + this.width) / this.m_aTileWidth);
         var _loc9_:Number = Math.ceil((_loc5_ + this.height) / this.m_aTileHeight);
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         else
         {
            _loc8_ -= _loc6_;
         }
         if(_loc7_ < 0)
         {
            _loc7_ = 0;
         }
         else
         {
            _loc9_ -= _loc7_;
         }
         _loc8_ = _loc8_ + _loc6_ > this.grid.width ? this.grid.width - _loc6_ : _loc8_;
         _loc9_ = _loc9_ + _loc7_ > this.grid.height ? this.grid.height - _loc7_ : _loc9_;
         return new Rectangle(_loc6_,_loc7_,_loc8_,_loc9_);
      }
      
      public function set tileHeight(param1:int) : void
      {
         var _loc2_:int = this.m_tileHeight;
         this.m_tileHeight = param1;
         this.updateAdjustedTileSizes(this.m_tileWidth,_loc2_,this.m_zoom);
      }
      
      public function getTilePosition(param1:int, param2:int) : Point
      {
         var _loc3_:Point = new Point();
         var _loc4_:Number = this.m_lastViewpoint.x - this.m_width * this.m_lastCX;
         var _loc5_:Number = this.m_lastViewpoint.y - this.m_height * this.m_lastCY;
         var _loc6_:int = -_loc4_;
         var _loc7_:int = -_loc5_;
         _loc3_.x = param1 * this.m_aTileWidth + _loc6_;
         _loc3_.y = param2 * this.m_aTileHeight + _loc7_;
         return _loc3_;
      }
      
      public function get baseCol() : uint
      {
         return this.m_baseCol;
      }
      
      public function get adjustedTileWidth() : int
      {
         return this.m_aTileWidth;
      }
      
      protected function updateAdjustedTileSizes(param1:int = 1, param2:int = 1, param3:Number = 1) : void
      {
         var _loc4_:int = this.m_aTileWidth;
         var _loc5_:int = this.m_aTileHeight;
         this.m_aTileWidth = int(Math.round(this.m_tileWidth * this.m_zoom));
         this.m_aTileHeight = int(Math.round(this.m_tileHeight * this.m_zoom));
         if(this.m_lastViewpoint)
         {
            this.m_lastViewpoint.x = this.m_aTileWidth * (this.m_lastViewpoint.x / _loc4_);
            this.m_lastViewpoint.y = this.m_aTileHeight * (this.m_lastViewpoint.y / _loc4_);
         }
         this.reset(true);
      }
      
      public function get tileHeight() : int
      {
         return this.m_tileHeight;
      }
      
      public function set tileWidth(param1:int) : void
      {
         var _loc2_:int = this.m_tileWidth;
         this.m_tileWidth = param1;
         this.updateAdjustedTileSizes(_loc2_,this.m_tileHeight,this.m_zoom);
      }
   }
}
