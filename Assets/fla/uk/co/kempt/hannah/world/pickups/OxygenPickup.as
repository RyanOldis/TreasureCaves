package uk.co.kempt.hannah.world.pickups
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Pickup;
   
   public class OxygenPickup extends Pickup
   {
       
      
      public function OxygenPickup()
      {
         super();
      }
      
      override public function get points() : int
      {
         return 25;
      }
      
      override protected function onPickup() : void
      {
         Engine.instance.player.addOxygen(1 / 10);
         Engine.instance.soundEngine.playSound(HannahSounds.OXYGEN_PICKUP);
         super.onPickup();
      }
   }
}
