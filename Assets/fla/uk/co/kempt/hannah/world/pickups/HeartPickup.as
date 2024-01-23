package uk.co.kempt.hannah.world.pickups
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Pickup;
   
   public class HeartPickup extends Pickup
   {
       
      
      public function HeartPickup()
      {
         super();
      }
      
      override public function get points() : int
      {
         return 500;
      }
      
      override protected function spawnPickupParticle() : void
      {
         Engine.instance.particleEngine.spawnHeartPickup(bounds.center);
      }
      
      override protected function onPickup() : void
      {
         Engine.instance.addLife(this);
         Engine.instance.soundEngine.playSound(HannahSounds.LIFE_PICKUP);
         super.onPickup();
      }
   }
}
