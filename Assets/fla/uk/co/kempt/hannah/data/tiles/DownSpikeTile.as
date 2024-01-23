package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.npc.DeadlyBlock;
   
   public class DownSpikeTile extends AbstractTile
   {
       
      
      public function DownSpikeTile()
      {
         super();
      }
      
      override public function get spriteClass() : Class
      {
         return DownSpikeSprite;
      }
      
      override public function get gameClass() : Class
      {
         return DeadlyBlock;
      }
   }
}
