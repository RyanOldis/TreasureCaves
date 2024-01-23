package uk.co.kempt.hannah.world.pickups
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Pickup;
   
   public class FuelPickup extends Pickup
   {
       
      
      public function FuelPickup()
      {
         super();
      }
      
      override public function get points() : int
      {
         return 25;
      }
      
      override protected function onPickup() : void
      {
         Engine.instance.player.addFuel(1 / 4);
         Engine.instance.soundEngine.playSound(HannahSounds.FUEL_PICKUP);
         super.onPickup();
      }
   }
}
