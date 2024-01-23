package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.FuelPickup;
   
   public class FuelTile extends AbstractTile
   {
       
      
      public function FuelTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return FuelSprite;
      }
      
      override public function get gameClass() : Class
      {
         return FuelPickup;
      }
   }
}
