package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.HeartPickup;
   
   public class HeartTile extends AbstractTile
   {
       
      
      public function HeartTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return HeartSprite;
      }
      
      override public function get gameClass() : Class
      {
         return HeartPickup;
      }
   }
}
