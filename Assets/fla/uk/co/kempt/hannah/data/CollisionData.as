package uk.co.kempt.hannah.data
{
   import flash.geom.Point;
   import uk.co.kempt.hannah.world.ICollidable;
   
   public class CollisionData
   {
       
      
      private var _source:ICollidable;
      
      private var _edge:uk.co.kempt.hannah.data.LineData;
      
      private var _distanceToCollisionSquared:Number;
      
      private var _trajectory:uk.co.kempt.hannah.data.LineData;
      
      private var _target:ICollidable;
      
      private var _collision:Point;
      
      private var _displacement:Point;
      
      public function CollisionData(param1:Point, param2:uk.co.kempt.hannah.data.LineData, param3:uk.co.kempt.hannah.data.LineData)
      {
         super();
         this._collision = param1;
         this._trajectory = param2;
         this._edge = param3;
         this._displacement = Boolean(param1) && Boolean(param2) ? param1.subtract(param2.start) : null;
         this._distanceToCollisionSquared = this._displacement.x * this._displacement.x + this._displacement.y * this._displacement.y;
      }
      
      public function get edge() : uk.co.kempt.hannah.data.LineData
      {
         return this._edge;
      }
      
      public function get distanceToCollisionSquared() : Number
      {
         return this._distanceToCollisionSquared;
      }
      
      public function get trajectory() : uk.co.kempt.hannah.data.LineData
      {
         return this._trajectory;
      }
      
      public function get target() : ICollidable
      {
         return this._target;
      }
      
      public function get displacement() : Point
      {
         return this._displacement;
      }
      
      public function get source() : ICollidable
      {
         return this._source;
      }
      
      public function clone(param1:Boolean = false) : CollisionData
      {
         var _loc2_:CollisionData = new CollisionData(this._collision,this._trajectory,this._edge);
         _loc2_._target = param1 ? this._source : this._target;
         _loc2_._source = param1 ? this._target : this._source;
         _loc2_._distanceToCollisionSquared = this._distanceToCollisionSquared;
         _loc2_._displacement = this._displacement;
         return _loc2_;
      }
      
      public function set target(param1:ICollidable) : void
      {
         this._target = param1;
      }
      
      public function reverse() : void
      {
         this._trajectory = new uk.co.kempt.hannah.data.LineData(this._trajectory.end,this._trajectory.start);
         this._displacement.x = -this._displacement.x;
         this._displacement.y = -this._displacement.y;
      }
      
      public function get collision() : Point
      {
         return this._collision;
      }
      
      public function set source(param1:ICollidable) : void
      {
         this._source = param1;
      }
   }
}
