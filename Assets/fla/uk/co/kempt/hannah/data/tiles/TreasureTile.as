package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.pickups.ChestPickup;
   
   public class TreasureTile extends AbstractTile
   {
       
      
      public function TreasureTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return TreasureSprite;
      }
      
      override public function get gameClass() : Class
      {
         return ChestPickup;
      }
   }
}
