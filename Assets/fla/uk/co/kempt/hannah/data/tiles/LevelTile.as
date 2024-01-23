package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.display.tiles.LevelTileSprite;
   
   public class LevelTile extends AbstractTile
   {
       
      
      public function LevelTile()
      {
         super();
         variant = Math.floor(Math.random() * 3);
      }
      
      override public function get renderable() : Boolean
      {
         return false;
      }
      
      override public function get crusting() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return LevelTileSprite;
      }
      
      override public function get crustingGroup() : int
      {
         return 1;
      }
      
      override public function get solid() : Boolean
      {
         return true;
      }
   }
}
