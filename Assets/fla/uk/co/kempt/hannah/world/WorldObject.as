package uk.co.kempt.hannah.world
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionCollection;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.data.tiles.AbstractTile;
   import uk.co.kempt.hannah.utils.CollisionResolver;
   
   public class WorldObject extends Sprite implements ICollidable
   {
      
      public static const TERMINAL_VELOCITY_Y:Number = 24;
      
      public static const TILE_WIDTH:int = 32;
      
      public static const TILE_HEIGHT:int = 32;
      
      public static const GRAVITY:Number = 0.3;
       
      
      private var _tile:AbstractTile;
      
      private var _uid:String;
      
      private var _collection:Vector.<uk.co.kempt.hannah.world.WorldObject>;
      
      private var _dead:Boolean;
      
      private var _collidingWithFloor:Boolean;
      
      private var _velocity:Point;
      
      private var _bounds:Boundaries;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _colliding:Boolean;
      
      public function WorldObject()
      {
         super();
         this._velocity = new Point();
         this._collection = new Vector.<uk.co.kempt.hannah.world.WorldObject>();
      }
      
      override public function get y() : Number
      {
         return this._y;
      }
      
      public function get colliding() : Boolean
      {
         return this._colliding;
      }
      
      public function stopAnimating() : void
      {
      }
      
      public function die() : void
      {
         this.dead = true;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function removeFromCollection(param1:uk.co.kempt.hannah.world.WorldObject) : uk.co.kempt.hannah.world.WorldObject
      {
         var _loc2_:int = this._collection.indexOf(param1);
         if(_loc2_ > -1)
         {
            this._collection.splice(_loc2_,1);
         }
         return param1;
      }
      
      public function get collection() : Vector.<uk.co.kempt.hannah.world.WorldObject>
      {
         return this._collection;
      }
      
      public function getCollectableByType(param1:Class) : uk.co.kempt.hannah.world.WorldObject
      {
         var _loc2_:uk.co.kempt.hannah.world.WorldObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._collection.length)
         {
            _loc2_ = this._collection[_loc3_];
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function set uid(param1:String) : void
      {
         this._uid = param1;
      }
      
      public function get updateable() : Boolean
      {
         return false;
      }
      
      private function updateCollisions() : CollisionData
      {
         var _loc1_:CollisionCollection = null;
         var _loc2_:CollisionData = null;
         var _loc3_:Vector.<ICollidable> = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!this.fixed && this.collidable && !(this.velocity.x == 0 && this.velocity.y == 0))
         {
            _loc3_ = Engine.SPACES.getPossibleCollidables(this);
            _loc1_ = CollisionResolver.testObjects(this,_loc3_);
            if(_loc1_.length > 0)
            {
               _loc2_ = _loc1_.getNearestSolid();
               if(_loc2_)
               {
                  this.velocity = _loc2_.displacement.clone();
                  if((_loc4_ = Math.sqrt(_loc2_.distanceToCollisionSquared)) > 0)
                  {
                     _loc5_ = 0.1;
                     _loc6_ = (_loc4_ - _loc5_) / _loc4_;
                     if(_loc4_ <= _loc5_)
                     {
                        this.velocity = new Point();
                     }
                     else
                     {
                        this.velocity.x *= _loc6_;
                        this.velocity.y *= _loc6_;
                     }
                  }
               }
               _loc1_.dispatchToTargets();
            }
         }
         return _loc2_;
      }
      
      public function get tile() : AbstractTile
      {
         return this._tile;
      }
      
      public function get solid() : Boolean
      {
         return true;
      }
      
      public function set velocity(param1:Point) : void
      {
         this._velocity = param1;
      }
      
      public function get bounds() : Boundaries
      {
         return this._bounds = this._bounds || this.createBounds();
      }
      
      public function onCollision(param1:CollisionData) : void
      {
      }
      
      public function addToCollection(param1:uk.co.kempt.hannah.world.WorldObject) : void
      {
         this._collection.push(param1);
      }
      
      protected function onCollideWithFloor(param1:CollisionData) : void
      {
      }
      
      public function set dead(param1:Boolean) : void
      {
         this._dead = param1;
      }
      
      public function update() : void
      {
         var _loc1_:CollisionData = null;
         if(!this.fixed)
         {
            this._collidingWithFloor = false;
            if(Math.abs(this.velocity.x) <= 1 / 20)
            {
               this.velocity.x = 0;
            }
            if(Math.abs(this.velocity.y) <= 1 / 20)
            {
               this.velocity.y = 0;
            }
            _loc1_ = this.updateCollisions();
            this.checkCollideWithFloor(_loc1_);
            this._colliding = !!_loc1_ ? true : false;
            if(_loc1_)
            {
               if(_loc1_.edge.isHorizontal)
               {
                  this.velocity.x = _loc1_.trajectory.displacementX;
               }
               else if(_loc1_.edge.isVertical)
               {
                  this.velocity.y = _loc1_.trajectory.displacementY;
               }
               _loc1_ = this.updateCollisions();
               this.checkCollideWithFloor(_loc1_);
            }
            this.x += this.velocity.x;
            this.y += this.velocity.y;
         }
      }
      
      public function get collidingWithFloor() : Boolean
      {
         return this._collidingWithFloor;
      }
      
      public function get uid() : String
      {
         return this._uid;
      }
      
      protected function createBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(this.x,this.y,Engine.TILE_SIZE,Engine.TILE_SIZE));
      }
      
      public function set tile(param1:AbstractTile) : void
      {
         this._tile = param1;
      }
      
      public function get velocity() : Point
      {
         return this._velocity;
      }
      
      public function get collidable() : Boolean
      {
         return true;
      }
      
      public function get dead() : Boolean
      {
         return this._dead;
      }
      
      override public function set x(param1:Number) : void
      {
         this._x = param1;
         super.x = param1;
         this.onPositionChanged();
      }
      
      override public function set y(param1:Number) : void
      {
         this._y = param1;
         super.y = param1;
         this.onPositionChanged();
      }
      
      protected function onPositionChanged() : void
      {
         this._bounds = null;
      }
      
      public function get fixed() : Boolean
      {
         return false;
      }
      
      private function checkCollideWithFloor(param1:CollisionData) : void
      {
         if(param1)
         {
            if(param1.edge.isHorizontal)
            {
               if(param1.trajectory.displacementY > 0)
               {
                  this._collidingWithFloor = true;
                  this.onCollideWithFloor(param1);
               }
            }
         }
      }
      
      override public function get x() : Number
      {
         return this._x;
      }
   }
}
