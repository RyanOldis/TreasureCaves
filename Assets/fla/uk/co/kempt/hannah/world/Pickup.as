package uk.co.kempt.hannah.world
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.CollisionData;
   
   public class Pickup extends WorldObject
   {
       
      
      public function Pickup()
      {
         super();
      }
      
      public function get points() : int
      {
         return 100;
      }
      
      public function get collectable() : Boolean
      {
         return false;
      }
      
      protected function onPickup() : void
      {
         Engine.instance.hud.points += this.points;
         this.spawnPickupParticle();
         die();
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         super.onCollision(param1);
         if(param1.source is Player)
         {
            if(this.collectable)
            {
               Player(param1.source).addToCollection(this);
            }
            this.onPickup();
         }
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
      
      protected function spawnPickupParticle() : void
      {
         Engine.instance.particleEngine.spawnPickup(bounds.center);
      }
   }
}
