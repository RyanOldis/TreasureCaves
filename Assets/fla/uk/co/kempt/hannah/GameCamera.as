package uk.co.kempt.hannah
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GameCamera
   {
      
      public static var ACCELERATION_EXPO:Number = 1.4;
      
      private static var INSTANCE:uk.co.kempt.hannah.GameCamera;
      
      public static var ACCELERATION_DAMPENING:Number = 180;
      
      public static var DECAY:Number = 0.7;
       
      
      private var _direction:Number;
      
      private var _viewport:Rectangle;
      
      private var _speed:Number;
      
      private var _speedX:Number = 0;
      
      private var _scrollBoundsMin:Point;
      
      private var _following:DisplayObject;
      
      private var _speedY:Number = 0;
      
      private var _scrollBoundsMax:Point;
      
      private var _slow:Number = 1;
      
      private var _prevPos:Point;
      
      private var _delayedFollow:Object;
      
      private var _lookaheadX:Number;
      
      private var _lookaheadY:Number;
      
      public function GameCamera(param1:Rectangle)
      {
         super();
         INSTANCE = INSTANCE || this;
         this._viewport = param1;
         this._lookaheadX = 0;
         this._lookaheadY = 0;
         this._speed = 0;
         this._direction = 0;
      }
      
      public static function get instance() : uk.co.kempt.hannah.GameCamera
      {
         return INSTANCE;
      }
      
      public function get slow() : Number
      {
         return this._slow;
      }
      
      public function get delayedFollow() : Object
      {
         return this._delayedFollow;
      }
      
      public function set slow(param1:Number) : void
      {
         this._slow = param1;
      }
      
      public function set scrollBoundsMax(param1:Point) : void
      {
         this._scrollBoundsMax = param1;
      }
      
      public function set viewport(param1:Rectangle) : void
      {
         this._viewport = param1;
      }
      
      public function get scrollBoundsMax() : Point
      {
         return this._scrollBoundsMax = this._scrollBoundsMax || new Point(Number.MAX_VALUE,Number.MAX_VALUE);
      }
      
      protected function getRealPosition(param1:DisplayObject) : Point
      {
         var _loc2_:Point = new Point(param1.x,param1.y);
         var _loc3_:DisplayObject = param1.parent;
         return _loc2_;
      }
      
      public function get scrollBoundsMin() : Point
      {
         return this._scrollBoundsMin = this._scrollBoundsMin || new Point(-Number.MAX_VALUE,-Number.MAX_VALUE);
      }
      
      public function update(param1:Boolean = false) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this.delayedFollow)
         {
            if(this.delayedFollow.delay-- <= 0)
            {
               this.following = this.delayedFollow.follow;
               this.delayedFollow = null;
            }
         }
         if(this.following)
         {
            _loc2_ = this.getRealPosition(this.following);
            _loc3_ = _loc2_.x - this.viewport.width / 2;
            _loc4_ = _loc2_.y - this.viewport.height / 2;
            if(param1)
            {
               this._speedX = 0;
               this._speedY = 0;
            }
            else
            {
               if(this._prevPos)
               {
                  _loc7_ = _loc2_.subtract(this._prevPos);
                  _loc10_ = _loc7_.x * (_loc9_ = 6);
                  _loc11_ = _loc7_.y * _loc9_;
                  _loc10_ = Math.max(-Engine.GAME_WIDTH / 2,Math.min(Engine.GAME_WIDTH / 2,_loc10_));
                  _loc11_ = Math.max(-Engine.GAME_HEIGHT / 2,Math.min(Engine.GAME_HEIGHT / 2,_loc11_));
                  _loc3_ += _loc10_;
                  _loc4_ += _loc11_;
               }
               _loc5_ = _loc3_ - this.viewport.x;
               _loc6_ = _loc4_ - this.viewport.y;
               _loc5_ = _loc5_ < 0 ? Math.pow(-_loc5_,ACCELERATION_EXPO) * -1 : Math.pow(_loc5_,ACCELERATION_EXPO);
               _loc6_ = _loc6_ < 0 ? Math.pow(-_loc6_,ACCELERATION_EXPO) * -1 : Math.pow(_loc6_,ACCELERATION_EXPO);
               this._speedX += _loc5_ / ACCELERATION_DAMPENING;
               this._speedY += _loc6_ / ACCELERATION_DAMPENING;
               this._speedX *= DECAY;
               this._speedY *= DECAY;
               if(Math.abs(this._speedX) < 1 / 20)
               {
                  this._speedX = 0;
               }
               if(Math.abs(this._speedY) < 1 / 20)
               {
                  this._speedY = 0;
               }
               _loc3_ = this.viewport.x + this._speedX;
               _loc4_ = this.viewport.y + this._speedY;
            }
            this.viewport.x = Math.max(this.scrollBoundsMin.x,Math.min(this.scrollBoundsMax.x,_loc3_));
            this.viewport.y = Math.max(this.scrollBoundsMin.y,Math.min(this.scrollBoundsMax.y,_loc4_));
            this._prevPos = _loc2_;
         }
      }
      
      public function get viewport() : Rectangle
      {
         return this._viewport;
      }
      
      public function set delayedFollow(param1:Object) : void
      {
         this._delayedFollow = param1;
      }
      
      public function set scrollBoundsMin(param1:Point) : void
      {
         this._scrollBoundsMin = param1;
      }
      
      public function get position() : Point
      {
         return this.viewport.topLeft;
      }
      
      private function angleDistance(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 - param2;
         while(_loc3_ > 180)
         {
            _loc3_ -= 360;
         }
         while(_loc3_ < -180)
         {
            _loc3_ += 360;
         }
         return _loc3_;
      }
      
      public function set following(param1:DisplayObject) : void
      {
         if(this.delayedFollow)
         {
            this.delayedFollow = null;
         }
         this._following = param1;
      }
      
      public function get following() : DisplayObject
      {
         return this._following;
      }
   }
}
