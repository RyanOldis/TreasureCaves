package com.neopets.util.display
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class BoundedIconRow extends MovieClip
   {
       
      
      protected var icons:Array;
      
      protected var boundingObj:DisplayObject;
      
      protected var _bounds:Rectangle;
      
      protected var midY:Number;
      
      public function BoundedIconRow()
      {
         super();
         this.icons = new Array();
         if(numChildren > 0)
         {
            this.setBoundingObj(getChildAt(0));
         }
         else
         {
            this.setBoundingObj(this);
         }
      }
      
      public function loadIconFrom(param1:String) : void
      {
         var _loc2_:IconLoader = new IconLoader();
         _loc2_.iconHeight = this._bounds.height;
         _loc2_.iconWidth = this._bounds.height;
         _loc2_.loadFrom(param1);
         addChild(_loc2_);
         this.icons.push(_loc2_);
         this.update();
      }
      
      public function set bounds(param1:Rectangle) : void
      {
         this._bounds = param1;
         this.update();
      }
      
      public function clearIcons() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = int(this.icons.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = this.icons.pop();
            removeChild(_loc1_);
            _loc2_--;
         }
      }
      
      public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc3_:DisplayObject = null;
         _loc1_ = this._bounds.width / (this.icons.length + 1);
         var _loc2_:Number = this._bounds.left + _loc1_;
         var _loc4_:int = 0;
         while(_loc4_ < this.icons.length)
         {
            _loc3_ = this.icons[_loc4_];
            _loc3_.x = _loc2_;
            _loc3_.y = this.midY;
            _loc2_ += _loc1_;
            _loc4_++;
         }
      }
      
      public function setBoundingObj(param1:DisplayObject) : void
      {
         if(param1 != null)
         {
            if(this.boundingObj != param1)
            {
               this._bounds = param1.getBounds(this);
               this.midY = this._bounds.top + this._bounds.height / 2;
               if(param1 != this)
               {
                  this.boundingObj = param1;
               }
               else
               {
                  this.boundingObj = null;
               }
            }
            this.update();
         }
      }
      
      public function showBounds() : void
      {
         if(this.boundingObj != null)
         {
            this.boundingObj.visible = false;
         }
      }
      
      public function get bounds() : Rectangle
      {
         return this._bounds;
      }
      
      public function hideBounds() : void
      {
         if(this.boundingObj != null)
         {
            this.boundingObj.visible = false;
         }
      }
   }
}
