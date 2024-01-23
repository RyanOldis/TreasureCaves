package uk.co.kempt.hannah.data
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import uk.co.kempt.hannah.world.ICollidable;
   
   public class Spaces
   {
      
      public static const GRID_HEIGHT:Number = 50;
      
      public static const GRID_WIDTH:Number = 50;
       
      
      private var _nonFixed:Vector.<ICollidable>;
      
      private var _spaces:Dictionary;
      
      public function Spaces()
      {
         super();
         this._spaces = new Dictionary();
         this._nonFixed = new Vector.<ICollidable>();
      }
      
      public function die() : void
      {
         this._spaces = null;
      }
      
      public function add(param1:ICollidable) : void
      {
         var _loc2_:Vector.<Space> = null;
         var _loc3_:int = 0;
         if(!param1.collidable)
         {
            return;
         }
         if(param1.fixed)
         {
            _loc2_ = this.getSpacesByArea(param1.bounds.topLeft,param1.bounds.bottomRight);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc2_[_loc3_].add(param1);
               _loc3_++;
            }
         }
         else
         {
            this._nonFixed.push(param1);
         }
      }
      
      protected function getSpaceName(param1:int, param2:int) : String
      {
         return param1 + "," + param2;
      }
      
      protected function getPossibleCollidablesByCollidable(param1:ICollidable) : Vector.<ICollidable>
      {
         var _loc2_:Point = param1.bounds.topLeft.clone();
         var _loc3_:Point = param1.bounds.bottomRight.clone();
         if(param1.velocity.x > 0)
         {
            _loc3_.x += param1.velocity.x;
         }
         else if(param1.velocity.x < 0)
         {
            _loc2_.x += param1.velocity.x;
         }
         if(param1.velocity.y > 0)
         {
            _loc3_.y += param1.velocity.y;
         }
         else if(param1.velocity.y < 0)
         {
            _loc2_.y += param1.velocity.y;
         }
         var _loc4_:Vector.<Space> = this.getSpacesByArea(param1.bounds.topLeft,param1.bounds.bottomRight,true);
         var _loc5_:Vector.<ICollidable>;
         return (_loc5_ = this.gatherSpaces(_loc4_)).concat(this._nonFixed);
      }
      
      protected function getSpacesByArea(param1:Point, param2:Point, param3:Boolean = false) : Vector.<Space>
      {
         var _loc8_:int = 0;
         var _loc4_:Point = this.positionToIndex(param1);
         var _loc5_:Point = this.positionToIndex(param2);
         if(param3)
         {
            --_loc4_.x;
            --_loc4_.y;
            _loc5_.x += 1;
            _loc5_.y += 1;
         }
         var _loc6_:Vector.<Space> = new Vector.<Space>();
         var _loc7_:int = _loc4_.y;
         while(_loc7_ <= _loc5_.y)
         {
            _loc8_ = _loc4_.x;
            while(_loc8_ <= _loc5_.x)
            {
               _loc6_.push(this.getSpace(_loc8_,_loc7_));
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      protected function gatherSpaces(param1:Vector.<Space>) : Vector.<ICollidable>
      {
         var _loc3_:Vector.<ICollidable> = null;
         var _loc4_:ICollidable = null;
         var _loc7_:int = 0;
         var _loc2_:Dictionary = new Dictionary();
         var _loc5_:Vector.<ICollidable> = new Vector.<ICollidable>();
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc3_ = param1[_loc6_].collection;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc7_];
               if(!_loc2_[_loc4_])
               {
                  _loc2_[_loc4_] = true;
                  _loc5_.push(_loc4_);
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      protected function getSpaceByPoint(param1:Point) : Space
      {
         return this.getSpaceByPosition(param1.x,param1.y);
      }
      
      protected function getSpaceNameByPosition(param1:Number, param2:Number) : String
      {
         var _loc3_:Point = this.positionToIndex(new Point(param1,param2));
         return this.getSpaceName(_loc3_.x,_loc3_.y);
      }
      
      public function getPossibleCollidables(param1:ICollidable) : Vector.<ICollidable>
      {
         return this.getPossibleCollidablesByCollidable(param1);
      }
      
      public function positionToIndex(param1:Point) : Point
      {
         var _loc2_:int = param1.x / GRID_WIDTH;
         var _loc3_:int = param1.y / GRID_HEIGHT;
         return new Point(_loc2_,_loc3_);
      }
      
      protected function getSpace(param1:int, param2:int) : Space
      {
         var _loc3_:String = this.getSpaceName(param1,param2);
         return this._spaces[_loc3_] = this._spaces[_loc3_] || new Space();
      }
      
      protected function getSpaceByPosition(param1:Number, param2:Number) : Space
      {
         var _loc3_:String = this.getSpaceNameByPosition(param1,param2);
         return this._spaces[_loc3_] = this._spaces[_loc3_] || new Space();
      }
   }
}
