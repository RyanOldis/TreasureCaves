package uk.co.kempt.hannah.utils
{
   import flash.geom.Point;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.CollisionCollection;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.data.LineData;
   import uk.co.kempt.hannah.world.ICollidable;
   
   public class CollisionResolver
   {
       
      
      public function CollisionResolver()
      {
         super();
      }
      
      public static function testObjects(param1:ICollidable, param2:Vector.<ICollidable>) : CollisionCollection
      {
         var _loc3_:CollisionCollection = new CollisionCollection();
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_.addCollisionData(testCollidableVsCollidable(param1,param2[_loc4_]));
            _loc4_++;
         }
         if(Engine.DEBUG)
         {
            _loc3_.debug();
         }
         return _loc3_;
      }
      
      private static function getRatio(param1:Number, param2:Number, param3:Number) : Number
      {
         return (param1 - param2) / (param3 - param2);
      }
      
      public static function testCollidableVsCollidable(param1:ICollidable, param2:ICollidable) : CollisionData
      {
         if(param2.dead)
         {
            return null;
         }
         var _loc3_:Point = param1.velocity.clone();
         var _loc4_:CollisionData = testCornersVsEdges(param1,param2,_loc3_);
         _loc3_.x = -_loc3_.x;
         _loc3_.y = -_loc3_.y;
         var _loc5_:CollisionData = testCornersVsEdges(param2,param1,_loc3_);
         if(Boolean(_loc4_) && Boolean(_loc5_))
         {
            if(_loc5_.distanceToCollisionSquared < _loc4_.distanceToCollisionSquared)
            {
               _loc5_.reverse();
               _loc4_ = _loc5_;
            }
         }
         else if(_loc5_)
         {
            _loc5_.reverse();
            _loc4_ = _loc5_;
         }
         if(_loc4_)
         {
            _loc4_.source = param1;
            _loc4_.target = param2;
         }
         return _loc4_;
      }
      
      public static function testReachedLedge(param1:ICollidable, param2:Vector.<ICollidable>) : CollisionCollection
      {
         var _loc4_:ICollidable = null;
         var _loc5_:LineData = null;
         var _loc6_:CollisionData = null;
         var _loc3_:CollisionCollection = new CollisionCollection();
         if(param1.velocity.x > 0)
         {
            _loc5_ = new LineData(param1.bounds.bottomRight,param1.bounds.bottomRight.add(new Point(0,10)));
         }
         else
         {
            _loc5_ = new LineData(param1.bounds.bottomLeft,param1.bounds.bottomLeft.add(new Point(0,10)));
         }
         var _loc7_:int = 0;
         while(_loc7_ < param2.length)
         {
            _loc4_ = param2[_loc7_];
            if(_loc6_ = testTrajectoryVsLine(_loc5_,_loc4_.bounds.topEdge))
            {
               _loc6_.source = param1;
               _loc6_.target = _loc4_;
               _loc3_.addCollisionData(_loc6_);
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      private static function testTrajectoryVsLine(param1:LineData, param2:LineData) : CollisionData
      {
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         if(param2.isHorizontal)
         {
            if((_loc4_ = getRatio(param2.start.y,param1.start.y,param1.end.y)) >= 0 && _loc4_ <= 1)
            {
               _loc3_ = param1.getPointOnLine(_loc4_);
               if(_loc3_.x < param2.minX || _loc3_.x > param2.maxX)
               {
                  _loc3_ = null;
               }
            }
         }
         else if(param2.isVertical)
         {
            if((_loc4_ = getRatio(param2.start.x,param1.start.x,param1.end.x)) >= 0 && _loc4_ <= 1)
            {
               _loc3_ = param1.getPointOnLine(_loc4_);
               if(_loc3_.y < param2.minY || _loc3_.y > param2.maxY)
               {
                  _loc3_ = null;
               }
            }
         }
         return !!_loc3_ ? new CollisionData(_loc3_,param1,param2) : null;
      }
      
      public static function testCornersVsEdges(param1:ICollidable, param2:ICollidable, param3:Point) : CollisionData
      {
         var _loc14_:LineData = null;
         if(!param1 || !param2)
         {
            trace("oh snap");
            return null;
         }
         if(param1 == param2)
         {
            return null;
         }
         var _loc4_:Point = param3;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:CollisionCollection = new CollisionCollection();
         if(_loc4_.x > 0)
         {
            _loc6_ = true;
            _loc8_ = true;
            _loc12_ = true;
         }
         else if(_loc4_.x < 0)
         {
            _loc5_ = true;
            _loc7_ = true;
            _loc10_ = true;
         }
         if(_loc4_.y > 0)
         {
            _loc7_ = true;
            _loc8_ = true;
            _loc9_ = true;
         }
         else if(_loc4_.y < 0)
         {
            _loc5_ = true;
            _loc6_ = true;
            _loc11_ = true;
         }
         if(_loc5_)
         {
            _loc14_ = new LineData(param1.bounds.topLeft,param1.bounds.topLeft.add(_loc4_));
            if(_loc9_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.topEdge));
            }
            if(_loc10_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.rightEdge));
            }
            if(_loc11_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.bottomEdge));
            }
            if(_loc12_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.leftEdge));
            }
         }
         if(_loc6_)
         {
            _loc14_ = new LineData(param1.bounds.topRight,param1.bounds.topRight.add(_loc4_));
            if(_loc9_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.topEdge));
            }
            if(_loc10_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.rightEdge));
            }
            if(_loc11_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.bottomEdge));
            }
            if(_loc12_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.leftEdge));
            }
         }
         if(_loc7_)
         {
            _loc14_ = new LineData(param1.bounds.bottomLeft,param1.bounds.bottomLeft.add(_loc4_));
            if(_loc9_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.topEdge));
            }
            if(_loc10_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.rightEdge));
            }
            if(_loc11_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.bottomEdge));
            }
            if(_loc12_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.leftEdge));
            }
         }
         if(_loc8_)
         {
            _loc14_ = new LineData(param1.bounds.bottomRight,param1.bounds.bottomRight.add(_loc4_));
            if(_loc9_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.topEdge));
            }
            if(_loc10_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.rightEdge));
            }
            if(_loc11_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.bottomEdge));
            }
            if(_loc12_)
            {
               _loc13_.addCollisionData(testTrajectoryVsLine(_loc14_,param2.bounds.leftEdge));
            }
         }
         return _loc13_.getNearest();
      }
   }
}
