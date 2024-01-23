package uk.co.kempt.hannah.world.triggerables
{
   import uk.co.kempt.hannah.world.pickups.YellowKeyPickup;
   
   public class YellowBlastDoor extends AbstractBlastDoor
   {
       
      
      public function YellowBlastDoor()
      {
         super();
      }
      
      override public function get dependencies() : Array
      {
         return [YellowKeyPickup];
      }
   }
}
