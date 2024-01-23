package uk.co.kempt.hannah.world.triggerables
{
   import uk.co.kempt.hannah.world.pickups.BlueKeyPickup;
   
   public class BlueBlastDoor extends AbstractBlastDoor
   {
       
      
      public function BlueBlastDoor()
      {
         super();
      }
      
      override public function get dependencies() : Array
      {
         return [BlueKeyPickup];
      }
   }
}
