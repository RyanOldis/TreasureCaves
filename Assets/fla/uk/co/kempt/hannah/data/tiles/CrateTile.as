package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.npc.DeadlyBlock;
   
   public class CrateTile extends AbstractTile
   {
       
      
      public function CrateTile()
      {
         super();
      }
      
      override public function get spriteClass() : Class
      {
         return UpSpikeSprite;
      }
      
      override public function get gameClass() : Class
      {
         return DeadlyBlock;
      }
   }
}
