package uk.co.kempt.hannah.world.pickups
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Pickup;
   
   public class ChestPickup extends Pickup
   {
       
      
      public function ChestPickup()
      {
         super();
      }
      
      override protected function onPickup() : void
      {
         ++Engine.instance.hud.chestsCollected;
         Engine.instance.soundEngine.playSound(HannahSounds.CHEST_PICKUP);
         super.onPickup();
      }
      
      override protected function spawnPickupParticle() : void
      {
         Engine.instance.particleEngine.spawnChestPickup(bounds.center);
      }
   }
}
