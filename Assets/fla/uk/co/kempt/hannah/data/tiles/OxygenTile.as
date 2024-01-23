package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.OxygenPickup;
   
   public class OxygenTile extends AbstractTile
   {
       
      
      public function OxygenTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return OxygenSprite;
      }
      
      override public function get gameClass() : Class
      {
         return OxygenPickup;
      }
   }
}
