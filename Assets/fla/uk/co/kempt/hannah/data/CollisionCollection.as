package uk.co.kempt.hannah.data
{
   import flash.display.Graphics;
   import uk.co.kempt.hannah.Engine;
   
   public class CollisionCollection
   {
       
      
      private var _collisions:Vector.<uk.co.kempt.hannah.data.CollisionData>;
      
      public function CollisionCollection()
      {
         super();
         this._collisions = new Vector.<uk.co.kempt.hannah.data.CollisionData>();
      }
      
      public function debug() : void
      {
         var _loc2_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc1_:Graphics = Engine.instance.display.graphics;
         var _loc3_:int = 0;
         while(_loc3_ < this._collisions.length)
         {
            _loc2_ = this._collisions[_loc3_];
            _loc1_.beginFill(65280,0.4);
            _loc1_.drawCircle(_loc2_.collision.x,_loc2_.collision.y,5);
            _loc1_.endFill();
            _loc3_++;
         }
      }
      
      public function get length() : Number
      {
         return this._collisions.length;
      }
      
      public function getNearest() : uk.co.kempt.hannah.data.CollisionData
      {
         var _loc1_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc2_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this._collisions.length)
         {
            _loc1_ = this._collisions[_loc4_];
            if(_loc1_.distanceToCollisionSquared < _loc3_)
            {
               _loc2_ = _loc1_;
               _loc3_ = _loc1_.distanceToCollisionSquared;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getNearestSolid() : uk.co.kempt.hannah.data.CollisionData
      {
         var _loc1_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc2_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this._collisions.length)
         {
            _loc1_ = this._collisions[_loc4_];
            if(_loc1_.target.solid && _loc1_.distanceToCollisionSquared < _loc3_)
            {
               _loc2_ = _loc1_;
               _loc3_ = _loc1_.distanceToCollisionSquared;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function addCollisionData(param1:uk.co.kempt.hannah.data.CollisionData) : void
      {
         if(param1)
         {
            this._collisions.push(param1);
         }
      }
      
      public function dispatchToTargets() : void
      {
         var _loc1_:uk.co.kempt.hannah.data.CollisionData = null;
         var _loc2_:uk.co.kempt.hannah.data.CollisionData = this.getNearestSolid();
         var _loc3_:Number = Number.MAX_VALUE;
         if(_loc2_)
         {
            _loc3_ = _loc2_.distanceToCollisionSquared;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._collisions.length)
         {
            _loc1_ = this._collisions[_loc4_];
            if(_loc1_.distanceToCollisionSquared <= _loc3_)
            {
               _loc1_.target.onCollision(_loc1_);
               _loc1_.source.onCollision(_loc1_.clone(true));
            }
            _loc4_++;
         }
      }
   }
}
