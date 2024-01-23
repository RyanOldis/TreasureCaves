package uk.co.kempt.hannah.world.pickups
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Pickup;
   
   public class BlueKeyPickup extends Pickup
   {
       
      
      public function BlueKeyPickup()
      {
         super();
      }
      
      override protected function onPickup() : void
      {
         Engine.instance.soundEngine.playSound(HannahSounds.KEY_PICKUP);
         super.onPickup();
      }
      
      override public function get collectable() : Boolean
      {
         return true;
      }
   }
}
