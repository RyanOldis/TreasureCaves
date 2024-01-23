package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.YellowKeyPickup;
   
   public class YellowKeyTile extends AbstractTile
   {
       
      
      public function YellowKeyTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return YellowKeySprite;
      }
      
      override public function get gameClass() : Class
      {
         return YellowKeyPickup;
      }
   }
}
