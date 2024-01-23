package uk.co.kempt.hannah.world.triggerables
{
   import uk.co.kempt.hannah.world.pickups.PurpleKeyPickup;
   
   public class PurpleBlastDoor extends AbstractBlastDoor
   {
       
      
      public function PurpleBlastDoor()
      {
         super();
      }
      
      override public function get dependencies() : Array
      {
         return [PurpleKeyPickup];
      }
   }
}
