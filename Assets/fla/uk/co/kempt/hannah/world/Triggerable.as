package uk.co.kempt.hannah.world
{
   import uk.co.kempt.hannah.data.CollisionData;
   
   public class Triggerable extends WorldObject
   {
       
      
      private var _triggered:Boolean;
      
      public function Triggerable()
      {
         super();
         this._triggered = false;
      }
      
      protected function get triggered() : Boolean
      {
         return this._triggered;
      }
      
      public function get dependencies() : Array
      {
         return [];
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         var _loc2_:WorldObject = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:WorldObject = null;
         super.onCollision(param1);
         if(this.dependencies.length > 0)
         {
            if(Boolean(param1.source) && param1.source is WorldObject)
            {
               _loc2_ = param1.source as WorldObject;
               _loc4_ = [];
               _loc3_ = 0;
               while(_loc3_ < this.dependencies.length)
               {
                  if(_loc5_ = _loc2_.getCollectableByType(this.dependencies[_loc3_]))
                  {
                     _loc4_.push(_loc5_);
                     _loc2_.removeFromCollection(_loc5_);
                  }
                  _loc3_++;
               }
               if(_loc4_.length == this.dependencies.length)
               {
                  this.onTriggered();
               }
               else
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_.length)
                  {
                     _loc2_.addToCollection(_loc4_[_loc3_]);
                     _loc3_++;
                  }
               }
            }
         }
         else
         {
            this.onTriggered();
         }
      }
      
      protected function set triggered(param1:Boolean) : void
      {
         this._triggered = param1;
      }
      
      protected function onTriggered() : void
      {
         this._triggered = true;
         die();
      }
   }
}
