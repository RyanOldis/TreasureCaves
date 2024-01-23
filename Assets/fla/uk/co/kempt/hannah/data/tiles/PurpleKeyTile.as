package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.PurpleKeyPickup;
   
   public class PurpleKeyTile extends AbstractTile
   {
       
      
      public function PurpleKeyTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return PurpleKeySprite;
      }
      
      override public function get gameClass() : Class
      {
         return PurpleKeyPickup;
      }
   }
}
