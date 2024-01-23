package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.BlueKeyPickup;
   
   public class BlueKeyTile extends AbstractTile
   {
       
      
      public function BlueKeyTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return BlueKeySprite;
      }
      
      override public function get gameClass() : Class
      {
         return BlueKeyPickup;
      }
   }
}
